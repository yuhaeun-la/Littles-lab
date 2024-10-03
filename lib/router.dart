import 'package:carelink/views/child/child_setup_page.dart';
import 'package:carelink/views/parents/listening_page.dart'; // ListeningPage 사용
import 'package:carelink/views/parents/parent_setup_page.dart';
import 'package:carelink/views/sharedview/setup_page.dart';
import 'package:carelink/views/sharedview/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:carelink/views/child/child_home_page.dart';
import 'package:carelink/views/parents/parent_home_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/setup',
      builder: (context, state) => SetupPage(),
    ),
    GoRoute(
      path: '/child-home',
      builder: (context, state) => const ChildHomePage(), // 아이 홈 페이지
    ),
    GoRoute(
      path: '/parent-home',
      builder: (context, state) => const ParentHomePage(), // 부모 홈 페이지
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
        return const ListeningPage(); // ListeningPage로 변경
      },
    ),
  ],
);
