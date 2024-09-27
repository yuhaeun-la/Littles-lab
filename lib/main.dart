// main.dart
import 'package:flutter/material.dart';
import 'package:carelink/router.dart';
import 'package:carelink/di.dart'; // setupLocator를 import 합니다.

void main() {
  setupLocator(); // 의존성 주입 설정
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      debugShowCheckedModeBanner: false,
      title: 'CareLink App',
    );
  }
}
