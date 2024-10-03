import 'package:carelink/views/child/child_setup_page.dart';
import 'package:carelink/views/parents/listening_page.dart';
import 'package:carelink/views/parents/parent_setup_page.dart';
import 'package:carelink/views/sharedview/setup_page.dart';
import 'package:carelink/views/sharedview/splash_screen.dart';  // SplashScreen 추가
import 'package:go_router/go_router.dart';
import 'package:carelink/views/child/child_home_page.dart'; // 아이 홈 페이지
import 'package:carelink/views/parents/parent_home_page.dart'; // 부모 홈 페이지

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/', // 기본 시작 경로를 SplashScreen으로 변경
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/setup',
      builder: (context, state) => SetupPage(),
    ),
    GoRoute(
      path: '/parent-home',
      builder: (context, state) => ParentHomePage(), // 부모 홈 페이지로 이동
    ),
    GoRoute(
      path: '/child-home',
      builder: (context, state) => ChildHomePage(), // 아이 홈 페이지로 이동
    ),
    GoRoute(
      path: '/parent-setup',
      builder: (context, state) => const ParentSetupPage(),
    ),
    GoRoute(
      path: '/child-setup',
      builder: (context, state) => ChildSetupPage(),
    ),
    GoRoute(
      path: '/webrtc/:isParent',
      builder: (context, state) {
        final isParent = state.pathParameters['isParent'] == 'true';
        return (isParent: isParent);
      },
    ),
  ],
);
