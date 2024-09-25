// views/setup_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SetupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('부모'),
              onPressed: () {
                context.go('/parent-setup'); // go_router를 통한 이동
              },
            ),
            ElevatedButton(
              child: Text('아이'),
              onPressed: () {
                context.go('/child-setup'); // go_router를 통한 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}
