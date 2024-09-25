// viewmodels/child_view_model.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../di.dart';

class ChildViewModel extends ChangeNotifier {
  final _firestore = getIt<FirebaseFirestore>();
  final codeController = TextEditingController();
  final tokenController = TextEditingController();
  bool _isPaired = false;

  bool get isPaired => _isPaired;

  Future<void> validateCode() async {
    if (!_validateInputs()) return;

    try {
      final parentData = await _fetchParentData();
      _validatePairingToken(parentData);
      await _saveChildData(parentData);
      _isPaired = true;
      notifyListeners();
    } catch (e) {
      throw Exception('페어링 중 오류가 발생했습니다: $e');
    }
  }

  bool _validateInputs() {
    if (codeController.text.trim().isEmpty || tokenController.text.trim().isEmpty) {
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

    return parentRef.docs.first.data();
  }

  void _validatePairingToken(Map<String, dynamic> parentData) {
    final token = tokenController.text.trim();
    final pairingTimestamp = parentData['pairingTimestamp'].toDate();

    if (parentData['pairingToken'] != token ||
        DateTime.now().difference(pairingTimestamp).inMinutes > 10) {
      throw Exception('페어링 토큰이 유효하지 않거나 만료되었습니다.');
    }
  }

  Future<void> _saveChildData(Map<String, dynamic> parentData) async {
    final parentId = parentData['id'];
    final childData = {
      'parentId': parentId,
      'paired': true,
      'pairingToken': tokenController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    };
    final childDocRef = await _firestore.collection('children').add(childData);

    await _firestore.collection('parents').doc(parentId).update({
      'pairedChildId': childDocRef.id,
    });
  }

  @override
  void dispose() {
    codeController.dispose();
    tokenController.dispose();
    super.dispose();
  }
}
