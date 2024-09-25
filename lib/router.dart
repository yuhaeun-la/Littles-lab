// router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'views/setup_page.dart';
import 'views/parent_setup_page.dart';
import 'views/child_setup_page.dart';
import 'views/webrtc_page.dart';

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
    GoRoute(
      path: '/webrtc/:isParent',
      builder: (context, state) {
        final isParent = state.params['isParent'] == 'true';
        return WebRTCPage(isParent: isParent);
      },
    ),
  ],
);
