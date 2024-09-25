// viewmodels/webrtc_view_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../di.dart';

class WebRTCViewModel extends ChangeNotifier {
  final _firestore = getIt<FirebaseFirestore>();
  late RTCPeerConnection _peerConnection;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  RTCVideoRenderer get localRenderer => _localRenderer;
  RTCVideoRenderer get remoteRenderer => _remoteRenderer;

  Future<void> initialize() async {
    await _initializeRenderers();
    await _createPeerConnection();
  }

  Future<void> _initializeRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _createPeerConnection() async {
    final config = {'iceServers': [{'urls': 'stun:stun.l.google.com:19302'}]};
    _peerConnection = await createPeerConnection(config);

    _peerConnection.onTrack = _handleOnTrack;
  }

  void _handleOnTrack(RTCTrackEvent event) {
    if (event.track.kind == 'audio') {
      _remoteRenderer.srcObject = event.streams[0];
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
