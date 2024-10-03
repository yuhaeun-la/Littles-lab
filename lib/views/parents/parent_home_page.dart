import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ParentHomePage extends StatelessWidget {
  const ParentHomePage({Key? key}) : super(key: key);

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
              onPressed: () {
                context.go('/webrtc/true'); // 부모가 아이의 소리를 듣는 ListeningPage로 이동
              },
              child: const Text('아이 소리 듣기 시작'),
            ),
          ],
        ),
      ),
    );
  }
}
