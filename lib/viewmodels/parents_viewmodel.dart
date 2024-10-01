import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/child.dart';
import '../di.dart';
import 'dart:math';

class ParentViewModel extends ChangeNotifier {
  final _firestore = getIt<FirebaseFirestore>();
  final _storage = getIt<FirebaseStorage>();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  File? _imageFile;
  Child? child;

  File? get imageFile => _imageFile;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadData() async {
    if (!_validateInputs()) return;

    try {
      final imageUrl = await _uploadImage();
      child = _createChildModel(imageUrl);
      await _saveToFirestore();
    } catch (e) {
      throw Exception('데이터 업로드 중 오류가 발생했습니다: $e');
    }
  }

  bool _validateInputs() {
    if (nameController.text.trim().isEmpty ||
        ageController.text.trim().isEmpty ||
        _imageFile == null) {
      throw Exception('모든 정보를 입력해주세요');
    }
    return true;
  }

  Future<String> _uploadImage() async {
    final storageRef = _storage.ref().child('child_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await storageRef.putFile(_imageFile!);
    return await storageRef.getDownloadURL();
  }

  Child _createChildModel(String imageUrl) {
    return Child(
      name: nameController.text.trim(),
      age: ageController.text.trim(),
      imageUrl: imageUrl,
      code: _generateCode(),
      pairingToken: _generateToken(),
      pairingTimestamp: DateTime.now(),
    );
  }

  Future<void> _saveToFirestore() async {
    await _firestore.collection('parents').add(child!.toJson());
    notifyListeners();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(5, (index) => chars[(chars.length * Random().nextDouble()).toInt()]).join();
  }

  String _generateToken() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(6, (index) => chars[(chars.length * Random().nextDouble()).toInt()]).join();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
