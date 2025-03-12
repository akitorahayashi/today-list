import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/page/home_page/home_page.dart';
import 'package:today_list/view/page/settings_page/settings_page.dart';

// GoRouterのプロバイダー
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      // ホーム画面
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),

      // 設定画面
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),

      // ワークスペース表示（URLスキームからのディープリンク用）
      GoRoute(
        path: '/workspace/:id',
        name: 'workspace',
        builder: (context, state) {
          final workspaceId = state.pathParameters['id'];
          return HomePage(initialWorkspaceId: workspaceId);
        },
      ),
    ],

    // URLスキームからのリンクを処理
    redirect: (context, state) {
      // カスタムURLスキームの処理
      final uri = Uri.parse(state.uri.toString());
      if (uri.scheme == 'todaylist' &&
          uri.host == 'workspace' &&
          uri.queryParameters.containsKey('id')) {
        final id = uri.queryParameters['id'];
        return '/workspace/$id';
      }
      return null; // リダイレクトなし
    },
  );
});
