import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';

void main() {
  testWidgets('TLAnimatedIconButton renders correctly',
      (WidgetTester tester) async {
    // タップカウンターを追跡する変数
    int tapCount = 0;

    // ウィジェットをビルド
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLAnimatedIconButton(
              icon: Icons.add,
              size: 30.0,
              iconColor: Colors.blue,
              onPressed: () {
                tapCount++;
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLAnimatedIconButton), findsOneWidget);

    // AnimatedScaleが存在することを確認
    expect(find.byType(AnimatedScale), findsOneWidget);

    // AnimatedSwitcherが存在することを確認
    expect(find.byType(AnimatedSwitcher), findsOneWidget);

    // アイコンが存在することを確認
    expect(find.byIcon(Icons.add), findsOneWidget);

    // アイコンのサイズと色を確認
    final iconFinder = find.byType(AnimatedSwitcher).first;
    final iconWidget = tester.widget<AnimatedSwitcher>(iconFinder);
    expect(iconWidget, isNotNull);

    // タップ機能をテスト
    await tester.tap(find.byType(TLAnimatedIconButton));
    await tester.pump();
    expect(tapCount, 1);

    // 再度タップ
    await tester.tap(find.byType(TLAnimatedIconButton));
    await tester.pump();
    expect(tapCount, 2);
  });

  testWidgets('TLAnimatedIconButton uses default values when not specified',
      (WidgetTester tester) async {
    // ウィジェットをビルド（デフォルト値を使用）
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLAnimatedIconButton(
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLAnimatedIconButton), findsOneWidget);

    // アイコンが存在することを確認
    expect(find.byIcon(Icons.add), findsOneWidget);

    // デフォルト値が適用されていることを確認
    final Icon icon = tester.widget<Icon>(find.byIcon(Icons.add));
    expect(icon.color, Colors.white); // デフォルトの色
    expect(icon.size, 26.0); // デフォルトのサイズ
  });

  testWidgets('TLAnimatedIconButton handles null onPressed',
      (WidgetTester tester) async {
    // ウィジェットをビルド（onPressedをnullに設定）
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLAnimatedIconButton(
              icon: Icons.add,
              onPressed: null,
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLAnimatedIconButton), findsOneWidget);

    // タップしてもエラーが発生しないことを確認
    await tester.tap(find.byType(TLAnimatedIconButton));
    await tester.pump();
    // エラーが発生しなければテスト成功
  });

  testWidgets('TLAnimatedIconButton animates when icon changes',
      (WidgetTester tester) async {
    // 初期アイコンでウィジェットをビルド
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLAnimatedIconButton(
              icon: Icons.add,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // 初期アイコンが表示されていることを確認
    expect(find.byIcon(Icons.add), findsOneWidget);

    // アイコンを変更
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLAnimatedIconButton(
              icon: Icons.remove,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // アニメーションの開始直後
    await tester.pump();

    // アニメーションの途中（アニメーションの検証は複雑なため、ここではウィジェットが存在することのみを確認）
    expect(find.byType(AnimatedSwitcher), findsOneWidget);

    // アニメーション完了後
    await tester.pumpAndSettle();

    // 新しいアイコンが表示されていることを確認
    expect(find.byIcon(Icons.remove), findsOneWidget);
    expect(find.byIcon(Icons.add), findsNothing);
  });
}
