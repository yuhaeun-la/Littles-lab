import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../di.dart';

class ChildViewModel extends ChangeNotifier {
  final _firestore = getIt<FirebaseFirestore>();
  final codeController = TextEditingController();

  bool _isPaired = false;
  bool get isPaired => _isPaired;

  Future<void> validateCode() async {
    if (!_validateInputs()) return;
    final parentData = await _fetchParentData();

    // 두 개의 인수를 넘김 (부모 데이터, 부모 문서 ID)
    await _saveChildData(parentData['data'], parentData['docId']);
    _isPaired = true;
    notifyListeners();
  }

  bool _validateInputs() {
    if (codeController.text.trim().isEmpty) {
      throw Exception('모든 입력 필드를 채워주세요');
    }
    return true;
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

  Future<void> _saveChildData(Map<String, dynamic> parentData, String parentDocId) async {
    final childData = {
      'paired': true,
      'createdAt': FieldValue.serverTimestamp(),
    };

    final childDocRef = await _firestore.collection('children').add(childData);

    await _firestore.collection('parents').doc(parentDocId).update({
      'pairedChildId': childDocRef.id,
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }
}
