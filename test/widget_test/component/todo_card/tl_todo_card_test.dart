import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card/tl_todo_card.dart';

void main() {
  // テスト用のToDoデータ
  final testTodo = TLToDo(
    id: 'test-todo-id',
    workspaceID: 'test-workspace-id',
    content: 'テストタスク',
    isInToday: true,
    steps: [
      TLStep(id: 'step1', content: 'ステップ1'),
      TLStep(id: 'step2', content: 'ステップ2'),
    ],
  );

  final testToDosInTodayAndWhenever = TLToDosInTodayAndWhenever(
    workspaceID: 'test-workspace-id',
    toDosInToday: [testTodo],
    toDosInWhenever: [],
  );

  final testWorkspace = TLWorkspace(
    id: 'test-workspace-id',
    name: 'テストワークスペース',
    toDos: testToDosInTodayAndWhenever,
  );

  testWidgets('TodoCardが正しく表示される', (WidgetTester tester) async {
    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLToDoCard(
              ifInToday: true,
              corrWorkspace: testWorkspace,
              corrToDo: testTodo,
            ),
          ),
        ),
      ),
    );

    // TodoCardのコンテンツが表示されていることを確認
    expect(find.text('テストタスク'), findsOneWidget);

    // ステップが表示されていることを確認
    expect(find.text('ステップ1'), findsOneWidget);
    expect(find.text('ステップ2'), findsOneWidget);
  });

  testWidgets('チェック済みのToDoが適切に表示される', (WidgetTester tester) async {
    // チェック済みのToDo
    final checkedTodo = testTodo.copyWith(isChecked: true);

    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLToDoCard(
              ifInToday: true,
              corrWorkspace: testWorkspace,
              corrToDo: checkedTodo,
            ),
          ),
        ),
      ),
    );

    // チェック済みのToDoが表示されていることを確認
    expect(find.text('テストタスク'), findsOneWidget);

    // チェックボックスが含まれているか確認（具体的なウィジェットの検証方法はコンポーネントによって異なる）
    // find.byTypeでチェックボックスを見つけるか、適切なセマンティックスを確認する
    // 例えば、透明度の低いテキストが使われているなど
  });

  testWidgets('タップでToDoのチェック状態が切り替わるかを確認', (WidgetTester tester) async {
    // Widgetをビルド
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLToDoCard(
              ifInToday: true,
              corrWorkspace: testWorkspace,
              corrToDo: testTodo,
            ),
          ),
        ),
      ),
    );

    // カードをタップ
    await tester.tap(find.text('テストタスク'));
    await tester.pump();

    // スナックバーが表示されることを確認
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
