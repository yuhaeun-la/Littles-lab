import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setup Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('부모'),
              onPressed: () {
                context.go('/parent-setup'); // 부모 설정 페이지로만 이동
              },
            ),
            ElevatedButton(
              child: const Text('아이'),
              onPressed: () {
                context.go('/child-setup'); // 아이 설정 페이지로만 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}
