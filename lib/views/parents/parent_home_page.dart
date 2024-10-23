import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({Key? key}) : super(key: key);

  // Firestore에서 페어링 상태 확인
  Future<bool> _checkPairingStatus() async {
    final parentDoc = await FirebaseFirestore.instance
        .collection('parents')
        .doc('parentDocId') // 실제 부모의 문서 ID 사용
        .get();

    if (parentDoc.exists) {
      return parentDoc['isPaired'] == true; // 페어링 상태 확인
    }
    return false; // 문서가 없거나 페어링되지 않은 경우
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('부모 홈'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                bool isPaired = await _checkPairingStatus(); // 페어링 상태 확인

                if (isPaired) {
                  context.go('/webrtc/true'); // 페어링 성공 시 WebRTC 페이지로 이동
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('아이와 페어링이 완료되지 않았습니다.')),
                  );
                }
              },
              child: const Text('아이 소리 듣기 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
