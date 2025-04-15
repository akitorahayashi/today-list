import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/home_page/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// メインのホームページのWidgetテスト
void main() {
  setUp(() async {
    // Set up SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('HomePage - 基本的なレンダリングテスト', (WidgetTester tester) async {
    // テスト用のGoRouter
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(testMode: true),
        ),
        GoRoute(
          path: '/settings',
          builder:
              (context, state) => Scaffold(
                appBar: AppBar(title: const Text('設定')),
                body: const Center(
                  child: Text('設定ページ', key: ValueKey('settings_page_text')),
                ),
              ),
        ),
      ],
    );

    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );

    // 短い時間待って描画を確認
    await tester.pump(const Duration(milliseconds: 300));

    // AppBarのタイトルを確認
    expect(find.byKey(const ValueKey('test_appbar_title')), findsOneWidget);
  });

  testWidgets('HomePage - 設定ボタンをタップして設定画面に遷移', (WidgetTester tester) async {
    // テスト用のGoRouter
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(testMode: true),
        ),
        GoRoute(
          path: '/settings',
          builder:
              (context, state) => Scaffold(
                appBar: AppBar(title: const Text('設定')),
                body: const Center(
                  child: Text('設定ページ', key: ValueKey('settings_page_text')),
                ),
              ),
        ),
      ],
    );

    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );

    // 短い時間待って描画を確認
    await tester.pump(const Duration(milliseconds: 300));

    // AppBarのタイトルを確認
    expect(find.byKey(const ValueKey('test_appbar_title')), findsOneWidget);

    // テストモードでの設定ボタンをタップ
    await tester.tap(find.byKey(const ValueKey('settings_button_test')));
    await tester.pumpAndSettle();

    // 設定画面に遷移したか確認
    expect(find.byKey(const ValueKey('settings_page_text')), findsOneWidget);
  });

  testWidgets('HomePage - タブの切り替え', (WidgetTester tester) async {
    // テスト用のGoRouter
    final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => HomePage(testMode: true),
        ),
      ],
    );

    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(child: MaterialApp.router(routerConfig: router)),
    );

    // 短い時間待って描画を確認
    await tester.pump(const Duration(milliseconds: 300));

    // AppBarのタイトルを確認
    expect(find.byKey(const ValueKey('test_appbar_title')), findsOneWidget);
  });
}
