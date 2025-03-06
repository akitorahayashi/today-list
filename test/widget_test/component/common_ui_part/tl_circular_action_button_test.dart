import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';

void main() {
  testWidgets('TLCircularActionButton renders correctly',
      (WidgetTester tester) async {
    // タップカウンターを追跡する変数
    int tapCount = 0;

    // ウィジェットをビルド
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLCircularActionButton(
              icon: Icons.add,
              backgroundColor: Colors.blue,
              borderColor: Colors.white,
              iconColor: Colors.white,
              onPressed: () {
                tapCount++;
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLCircularActionButton), findsOneWidget);

    // DecoratedBoxが存在することを確認
    expect(find.byType(DecoratedBox), findsOneWidget);

    // アイコンが存在することを確認
    expect(find.byIcon(Icons.add), findsOneWidget);

    // タップ機能をテスト - GestureDetectorを直接タップ
    await tester.tap(find.byType(GestureDetector).first, warnIfMissed: false);
    await tester.pump();
    expect(tapCount, 1);
  });

  testWidgets('TLCircularActionButton uses default size when not specified',
      (WidgetTester tester) async {
    // ウィジェットをビルド（サイズを指定しない）
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLCircularActionButton(
              icon: Icons.add,
              backgroundColor: Colors.blue,
              borderColor: Colors.white,
              iconColor: Colors.white,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLCircularActionButton), findsOneWidget);

    // SizedBoxが存在することを確認
    expect(find.byType(SizedBox), findsWidgets);

    // デフォルトサイズが70であることを確認
    final SizedBox sizedBox = tester.widget<SizedBox>(
      find
          .descendant(
            of: find.byType(TLCircularActionButton),
            matching: find.byType(SizedBox),
          )
          .first,
    );
    expect(sizedBox.width, 70);
    expect(sizedBox.height, 70);
  });

  testWidgets('TLCircularActionButton handles null onPressed',
      (WidgetTester tester) async {
    // ウィジェットをビルド（onPressedをnullに設定）
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLCircularActionButton(
              icon: Icons.add,
              backgroundColor: Colors.blue,
              borderColor: Colors.white,
              iconColor: Colors.white,
              onPressed: null,
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLCircularActionButton), findsOneWidget);

    // タップしてもエラーが発生しないことを確認
    await tester.tap(find.byType(GestureDetector).first, warnIfMissed: false);
    await tester.pump();
    // エラーが発生しなければテスト成功
  });

  testWidgets('TLCircularActionButton applies correct colors',
      (WidgetTester tester) async {
    // ウィジェットをビルド（特定の色を指定）
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: TLCircularActionButton(
              icon: Icons.add,
              backgroundColor: Colors.red,
              borderColor: Colors.green,
              iconColor: Colors.blue,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが存在することを確認
    expect(find.byType(TLCircularActionButton), findsOneWidget);

    // DecoratedBoxが存在することを確認
    expect(find.byType(DecoratedBox), findsOneWidget);

    // 色が正しく適用されていることを確認
    final DecoratedBox decoratedBox =
        tester.widget<DecoratedBox>(find.byType(DecoratedBox));
    final BoxDecoration decoration = decoratedBox.decoration as BoxDecoration;

    expect(decoration.color, Colors.red);
    expect((decoration.border as Border).top.color, Colors.green);

    // アイコンの色を確認
    final Icon icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, Colors.blue);
  });
}
