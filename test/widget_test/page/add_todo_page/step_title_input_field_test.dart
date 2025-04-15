import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/step_title_input_field.dart';

void main() {
  testWidgets('ステップタイトル入力フィールドが正しく表示される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();
    String addedStepTitle = '';

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StepTitleInputField(
              stepTitleController: controller,
              onAddOrEditStep: (title) {
                addedStepTitle = title;
              },
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 入力フィールドが表示されていることを確認
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Step'), findsOneWidget);

    // 追加ボタンが初期状態では無効化されていることを確認（テキストが空のため）
    final addButtonFinder = find.byIcon(Icons.add);
    expect(addButtonFinder, findsOneWidget);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.ancestor(
              of: addButtonFinder,
              matching: find.byType(AnimatedOpacity),
            ),
          )
          .opacity,
      0.25, // 無効状態の透明度
    );

    // テキストを入力
    await tester.enterText(find.byType(TextField), 'テストステップ');
    await tester.pump();

    // 追加ボタンが有効化されることを確認
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.ancestor(
              of: addButtonFinder,
              matching: find.byType(AnimatedOpacity),
            ),
          )
          .opacity,
      1.0, // 有効状態の透明度
    );

    // 追加ボタンを押す
    await tester.tap(addButtonFinder);
    await tester.pump();

    // コールバックが実行されたことを確認
    expect(addedStepTitle, 'テストステップ');
  });

  testWidgets('入力内容の変更がUIに反映される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StepTitleInputField(
              stepTitleController: controller,
              onAddOrEditStep: (title) {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // テキストを入力
    await tester.enterText(find.byType(TextField), 'テストステップ');
    await tester.pump();

    // 入力されたテキストが表示されていることを確認
    expect(find.text('テストステップ'), findsOneWidget);

    // テキストをクリア
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    // テキストがクリアされたことを確認
    expect(find.text('テストステップ'), findsNothing);
  });

  testWidgets('前の編集内容が入力欄に表示される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController(text: '編集中のステップ');

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StepTitleInputField(
              stepTitleController: controller,
              onAddOrEditStep: (title) {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 初期値が表示されていることを確認
    expect(find.text('編集中のステップ'), findsOneWidget);

    // 追加ボタンが有効化されていることを確認（テキストが入力済み）
    final addButtonFinder = find.byIcon(Icons.add);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.ancestor(
              of: addButtonFinder,
              matching: find.byType(AnimatedOpacity),
            ),
          )
          .opacity,
      1.0, // 有効状態の透明度
    );
  });

  testWidgets('空白のみの入力では追加ボタンが有効にならない', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: StepTitleInputField(
              stepTitleController: controller,
              onAddOrEditStep: (title) {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // 空白のみのテキストを入力
    await tester.enterText(find.byType(TextField), '   ');
    await tester.pump();

    // 追加ボタンが無効状態のままであることを確認
    final addButtonFinder = find.byIcon(Icons.add);
    expect(
      tester
          .widget<AnimatedOpacity>(
            find.ancestor(
              of: addButtonFinder,
              matching: find.byType(AnimatedOpacity),
            ),
          )
          .opacity,
      0.25, // 無効状態の透明度
    );
  });
}
