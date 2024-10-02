import 'package:cloud_firestore/cloud_firestore.dart';

class SignalingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createOffer(String sdp) async {
    await _firestore.collection('calls').doc('webrtc').set({
      'offer': {'sdp': sdp, 'type': 'offer'}
    });
  }

  Stream<DocumentSnapshot> onAnswer() {
    return _firestore.collection('calls').doc('webrtc').snapshots();
  }

  Future<void> setAnswer(String sdp) async {
    await _firestore.collection('calls').doc('webrtc').update({
      'answer': {'sdp': sdp, 'type': 'answer'}
    });
  }

  Future<void> addIceCandidate(Map<String, dynamic> candidate) async {
    await _firestore.collection('calls').doc('webrtc').collection('iceCandidates').add(candidate);
  }

  Stream<QuerySnapshot> onIceCandidate() {
    return _firestore.collection('calls').doc('webrtc').collection('iceCandidates').snapshots();
  }
}
