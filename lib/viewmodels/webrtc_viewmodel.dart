import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:carelink/services/signaling_service.dart';

class WebRTCViewModel extends ChangeNotifier {
  late RTCPeerConnection _peerConnection;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final SignalingService _signalingService = SignalingService();

  MediaStream? _localStream; // 로컬 오디오 스트림 추가

  RTCVideoRenderer get localRenderer => _localRenderer;
  RTCVideoRenderer get remoteRenderer => _remoteRenderer;

  // 초기화 로직
  Future<void> initialize() async {
    await _initializeRenderers();
    await _createPeerConnection();
  }

  // 렌더러 초기화
  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  // 피어 커넥션 생성
  Future<void> _createPeerConnection() async {
    final config = {'iceServers': [{'urls': 'stun:stun.l.google.com:19302'}]};
    _peerConnection = await createPeerConnection(config);

    // 로컬 오디오 스트림 추가 (마이크 활성화)
    await _startLocalAudioStream();

    // ICE Candidate 발생 시 처리
    _peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      if (candidate.candidate != null && candidate.sdpMid != null && candidate.sdpMLineIndex != null) {
        _signalingService.addIceCandidate({
          'candidate': candidate.candidate,
          'sdpMid': candidate.sdpMid,
          'sdpMLineIndex': candidate.sdpMLineIndex,
        });
      }
    };

    // 부모가 듣기 시작할 때 Offer 수신
    _signalingService.onOffer().listen((snapshot) async {
      if (snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        String sdp = data['offer']['sdp'];
        RTCSessionDescription offer = RTCSessionDescription(sdp, 'offer');
        await _peerConnection.setRemoteDescription(offer);

        // Answer 생성 후 전송
        RTCSessionDescription answer = await _peerConnection.createAnswer();
        await _peerConnection.setLocalDescription(answer);
        await _signalingService.setAnswer(answer.sdp!);
      }
    });

    // Answer 수신 후 처리
    _signalingService.onAnswer().listen((snapshot) async {
      if (snapshot.data() != null) {
        var data = snapshot.data() as Map<String, dynamic>;
        String sdp = data['answer']['sdp'];
        RTCSessionDescription answer = RTCSessionDescription(sdp, 'answer');
        await _peerConnection.setRemoteDescription(answer);
      }
    });

    // ICE Candidate 교환 처리
    _signalingService.onIceCandidate().listen((snapshot) {
      var candidates = snapshot.docs;
      for (var doc in candidates) {
        var data = doc.data() as Map<String, dynamic>;
        RTCIceCandidate candidate = RTCIceCandidate(
          data['candidate'],
          data['sdpMid'],
          data['sdpMLineIndex'],
        );
        _peerConnection.addCandidate(candidate);  // Updated method
      }
    });
  }

  // 로컬 오디오 스트림 시작 (마이크 활성화)
  Future<void> _startLocalAudioStream() async {
    _localStream = await navigator.mediaDevices.getUserMedia({'audio': true});
    _peerConnection.addStream(_localStream!);
  }

  // 소리 중단 시 로컬 오디오 스트림 정지 (마이크 비활성화)
  void stopAudio() {
    _localStream?.getTracks().forEach((track) {
      track.stop();  // 트랙을 중단하여 마이크 비활성화
    });
    _peerConnection.close();
    notifyListeners();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _localStream?.dispose();
    _peerConnection.close();
    super.dispose();
  }
}
