// router.dart
import 'package:carelink/views/child/child_setup_page.dart';
import 'package:carelink/views/listening_page.dart';
import 'package:carelink/views/parents/parent_setup_page.dart';
import 'package:carelink/views/sharedview/setup_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => SetupPage(),
    ),
    GoRoute(
      path: '/parent-setup',
      builder: (context, state) => ParentSetupPage(),
    ),
    GoRoute(
      path: '/child-setup',
      builder: (context, state) => ChildSetupPage(),
    ),
    GoRoute( // 자랑 할 부분
      path: '/webrtc/:isParent',
      builder: (context, state) {
        final isParent = state.pathParameters['isParent'] == 'true';
        return WebRTCPage(isParent: isParent);
      },
    ),
  ],
);
