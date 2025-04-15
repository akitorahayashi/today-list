import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/select_today_or_whenever_button.dart';

void main() {
  testWidgets('Today/Wheneverボタンが初期状態で正しく表示される', (WidgetTester tester) async {
    // 状態変数の初期化
    bool isToday = true;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SelectTodayOrWheneverButton(
              ifInToday: isToday,
              onChanged: (value) {
                isToday = value;
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 「今日」と「いつでも」のボタンが表示されていることを確認
    expect(find.text('今日'), findsOneWidget);
    expect(find.text(' いつでも '), findsOneWidget);

    // 初期状態では「今日」が選択されていることを確認
    final toggleButtons = find.byType(ToggleButtons);
    expect(toggleButtons, findsOneWidget);

    final toggleWidget = tester.widget<ToggleButtons>(toggleButtons);
    expect(toggleWidget.isSelected[0], true); // 「今日」が選択されている
    expect(toggleWidget.isSelected[1], false); // 「いつでも」は選択されていない
  });

  testWidgets('ボタンを押した時に正しく切り替わることを確認', (WidgetTester tester) async {
    // 状態変数の初期化
    bool isToday = true;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return SelectTodayOrWheneverButton(
                  ifInToday: isToday,
                  onChanged: (value) {
                    setState(() {
                      isToday = value;
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 「いつでも」ボタンをタップ
    await tester.tap(find.text(' いつでも '));
    await tester.pumpAndSettle();

    // 選択状態が切り替わったことを確認
    final toggleWidget = tester.widget<ToggleButtons>(
      find.byType(ToggleButtons),
    );
    expect(toggleWidget.isSelected[0], false); // 「今日」が非選択
    expect(toggleWidget.isSelected[1], true); // 「いつでも」が選択
    expect(isToday, false); // 状態変数も更新された

    // 「今日」ボタンをタップ
    await tester.tap(find.text('今日'));
    await tester.pumpAndSettle();

    // 選択状態が元に戻ったことを確認
    final updatedToggleWidget = tester.widget<ToggleButtons>(
      find.byType(ToggleButtons),
    );
    expect(updatedToggleWidget.isSelected[0], true); // 「今日」が選択
    expect(updatedToggleWidget.isSelected[1], false); // 「いつでも」が非選択
    expect(isToday, true); // 状態変数も更新された
  });

  testWidgets('初期状態で「いつでも」を選択した場合のテスト', (WidgetTester tester) async {
    // 状態変数の初期化
    bool isToday = false; // 「いつでも」を選択

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SelectTodayOrWheneverButton(
              ifInToday: isToday,
              onChanged: (value) {
                isToday = value;
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 初期状態で「いつでも」が選択されていることを確認
    final toggleWidget = tester.widget<ToggleButtons>(
      find.byType(ToggleButtons),
    );
    expect(toggleWidget.isSelected[0], false); // 「今日」が非選択
    expect(toggleWidget.isSelected[1], true); // 「いつでも」が選択
  });
}
