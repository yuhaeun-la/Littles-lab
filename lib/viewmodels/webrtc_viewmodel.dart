import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:carelink/services/signaling_service.dart';

class WebRTCViewModel extends ChangeNotifier {
  late RTCPeerConnection _peerConnection;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final SignalingService _signalingService = SignalingService();  // 시그널링 서비스

  RTCVideoRenderer get localRenderer => _localRenderer;
  RTCVideoRenderer get remoteRenderer => _remoteRenderer;

  bool _isStreaming = false;
  bool get isStreaming => _isStreaming;

  Future<void> initialize({required bool isParent}) async {
    await _initializeRenderers();
    await _createPeerConnection(isParent);
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _createPeerConnection(bool isParent) async {
    final config = {'iceServers': [{'urls': 'stun:stun.l.google.com:19302'}]};
    _peerConnection = await createPeerConnection(config);

    // 부모일 경우 Remote Track 처리 (아이의 소리를 받음)
    if (isParent) {
      _peerConnection.onTrack = (RTCTrackEvent event) {
        if (event.track.kind == 'audio') {
          _remoteRenderer.srcObject = event.streams[0];
        }
      };
    }

    // 아이일 경우 자동으로 오디오 스트림을 전송
    if (!isParent) {
      final mediaStream = await navigator.mediaDevices.getUserMedia({'audio': true});
      mediaStream.getTracks().forEach((track) {
        _peerConnection.addTrack(track, mediaStream);
      });
    }

    // Offer/Answer 및 ICE Candidate 교환을 위한 시그널링 처리
    await _setupSignaling(isParent);
  }

  Future<void> _setupSignaling(bool isParent) async {
    // 부모가 아니라면 (아이 측에서 Offer 생성)
    if (!isParent) {
      RTCSessionDescription offer = await _peerConnection.createOffer();
      await _peerConnection.setLocalDescription(offer);
      await _signalingService.createOffer(offer.sdp!);

      // 부모로부터 Answer를 대기
      _signalingService.onAnswer().listen((snapshot) async {
        if (snapshot.data() != null) {
          String sdp = snapshot.data()?['answer']['sdp'];
          RTCSessionDescription answer = RTCSessionDescription(sdp, 'answer');
          await _peerConnection.setRemoteDescription(answer);
        }
      });
    } else {
      // 부모가 듣기 시작할 때는 Offer를 대기
      _signalingService.onOffer().listen((snapshot) async {
        if (snapshot.data() != null) {
          String sdp = snapshot.data()?['offer']['sdp'];
          RTCSessionDescription offer = RTCSessionDescription(sdp, 'offer');
          await _peerConnection.setRemoteDescription(offer);

          // Answer 생성 후 전송
          RTCSessionDescription answer = await _peerConnection.createAnswer();
          await _peerConnection.setLocalDescription(answer);
          await _signalingService.setAnswer(answer.sdp!);
        }
      });
    }

    // ICE Candidate 교환 처리
    _peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      _signalingService.addIceCandidate({
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
      });
    };

    // 부모가 아니라면, 부모로부터의 ICE Candidate 수신 처리
    if (!isParent) {
      _signalingService.onIceCandidate().listen((snapshot) {
        for (var doc in snapshot.docs) {
          var data = doc.data() as Map<String, dynamic>;
          RTCIceCandidate candidate = RTCIceCandidate(
            data['candidate'],
            data['sdpMid'],
            data['sdpMLineIndex'],
          );
          _peerConnection.addIceCandidate(candidate);
        }
      });
    }
  }

  Future<void> startListening() async {
    // 부모가 듣기 버튼을 눌렀을 때 처리하는 메서드
    if (!_isStreaming) {
      _isStreaming = true;
      notifyListeners();
      await initialize(isParent: true);
    }
  }

  Future<void> stopListening() async {
    // 전송 중단 처리
    if (_isStreaming) {
      _isStreaming = false;
      notifyListeners();
      _peerConnection.close();
      await initialize(isParent: true);
    }
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection.close();
    super.dispose();
  }
}
