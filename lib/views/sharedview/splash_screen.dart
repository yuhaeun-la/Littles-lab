import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  // 사용자 타입을 확인하여 해당 페이지로 이동하는 함수
  Future<void> _checkUserType() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');

    // 역할에 따라 자동으로 페이지로 이동
    if (userType == 'parent') {
      context.go('/parent-home'); // 부모 홈으로 이동
    } else if (userType == 'child') {
      context.go('/child-home'); // 아이 홈으로 이동
    } else {
      context.go('/setup'); // 처음일 경우 Setup 페이지로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()), // 로딩 화면
    );
  }
}
