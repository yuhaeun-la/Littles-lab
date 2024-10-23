import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../di.dart';

class ChildViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final codeController = TextEditingController();

  bool _isPaired = false;
  bool get isPaired => _isPaired;

  Future<void> validateCode() async {
    if (codeController.text.trim().isEmpty) return;

    final parentData = await _fetchParentData();

    // 페어링 성공 시 Firestore에 상태 저장
    await _firestore.collection('parents').doc(parentData['docId']).update({
      'isPaired': true, // Firestore에서 부모 문서 업데이트
    });

    _isPaired = true;
    notifyListeners();
  }

  Future<Map<String, dynamic>> _fetchParentData() async {
    final code = codeController.text.trim();
    final parentRef = await _firestore.collection('parents').where('code', isEqualTo: code).get();

    if (parentRef.docs.isEmpty) {
      throw Exception('부모 코드가 유효하지 않습니다.');
    }

    return {
      'data': parentRef.docs.first.data(),
      'docId': parentRef.docs.first.id
    };
  }
}
