import 'package:document_manager/constants/go_router_path.dart';
import 'package:document_manager/debug/debug_page.dart';
import 'package:document_manager/views/home_page.dart';
import 'package:document_manager/views/timeline_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// GoRouterによる画面遷移の構成を定義するUtilクラスです。
class GoRouterUtil {
  static GoRouter router = GoRouter(
    initialLocation: RouterPath.home,
    routes: <RouteBase>[
      GoRoute(
        path: RouterPath.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
          // return const DebugPage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: RouterPath.debug,
            builder: (BuildContext context, GoRouterState state) {
              return const DebugPage();
            },
          ),
          GoRoute(
            path: RouterPath.timeline,
            builder: (BuildContext context, GoRouterState state) {
              return const TimelinePage();
            },
          ),
        ],
      ),
    ],
  );
}
