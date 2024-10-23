import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SetupPage extends StatelessWidget {
  Future<void> _setUserType(String userType, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userType', userType);

    if (userType == 'parent') {
      context.go('/parent-setup'); // 부모 설정 페이지로 이동
    } else if (userType == 'child') {
      context.go('/child-setup'); // 아이 설정 페이지로 이동
    }
  }

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
                ///TODO : 이미 등록 단계에서 -setUserType을 해야함
                _setUserType('parent', context); // 부모 역할 저장 및 이동
              },
            ),
            ElevatedButton(
              child: const Text('아이'),
              onPressed: () {
                _setUserType('child', context); // 아이 역할 저장 및 이동
              },
            ),
          ],
        ),
      ),
    );
  }
}
