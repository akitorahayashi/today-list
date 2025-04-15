import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/todo_title_input_field.dart';

void main() {
  testWidgets('ToDoタイトル入力フィールドが正しく表示される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();
    bool addButtonPressed = false;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ToDoTitleInputField(
              toDoTitleController: controller,
              onCompleteEditing: () async {
                addButtonPressed = true;
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
    expect(find.text('ToDo'), findsOneWidget);

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
    await tester.enterText(find.byType(TextField), 'テストToDo');
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
    expect(addButtonPressed, true);
  });

  testWidgets('入力内容の変更がUIに反映される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ToDoTitleInputField(
              toDoTitleController: controller,
              onCompleteEditing: () async {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // テキストを入力
    await tester.enterText(find.byType(TextField), 'テストToDo');
    await tester.pump();

    // 入力されたテキストが表示されていることを確認
    expect(find.text('テストToDo'), findsOneWidget);

    // テキストをクリア
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    // テキストがクリアされたことを確認
    expect(find.text('テストToDo'), findsNothing);
  });

  testWidgets('外部からのコントローラー更新がUIに反映される', (WidgetTester tester) async {
    // コントローラー作成
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ToDoTitleInputField(
              toDoTitleController: controller,
              onCompleteEditing: () async {},
            ),
          ),
        ),
      ),
    );

    // ウィジェットが描画されるまで待機
    await tester.pumpAndSettle();

    // コントローラー経由でテキストを設定
    controller.text = '外部更新テキスト';
    await tester.pump();

    // 更新されたテキストが表示されていることを確認
    expect(find.text('外部更新テキスト'), findsOneWidget);
  });
}
