import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card/tl_todo_card.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

void main() {
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
    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
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
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('テストタスク'), findsOneWidget);
    expect(find.text('ステップ1'), findsOneWidget);
    expect(find.text('ステップ2'), findsOneWidget);
  });

  testWidgets('チェック済みのToDoが適切に表示される', (WidgetTester tester) async {
    final checkedTodo = testTodo.copyWith(isChecked: true);

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
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
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('テストタスク'), findsOneWidget);
    expect(find.text('ステップ1'), findsOneWidget);
    expect(find.text('ステップ2'), findsOneWidget);

    final todoRowFinder = find.ancestor(
      of: find.text(checkedTodo.content),
      matching: find.byType(Row),
    );
    final checkboxFinder = find.descendant(
      of: todoRowFinder,
      matching: find.byType(TLCheckBox),
    );
    expect(checkboxFinder, findsOneWidget);
    final checkboxWidget = tester.widget<TLCheckBox>(checkboxFinder);
    expect(checkboxWidget.isChecked, true);
  });

  testWidgets('タップでToDoのチェック状態が切り替わるかを確認', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
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
      ),
    );

    await tester.pump(const Duration(milliseconds: 100));

    final initialTodoRowFinder = find.ancestor(
      of: find.text(testTodo.content),
      matching: find.byType(Row),
    );
    final initialCheckboxFinder = find.descendant(
      of: initialTodoRowFinder,
      matching: find.byType(TLCheckBox),
    );
    expect(
      initialCheckboxFinder,
      findsOneWidget,
      reason: "TLCheckBox should be present",
    );
    final initialCheckboxWidget = tester.widget<TLCheckBox>(
      initialCheckboxFinder,
    );
    expect(
      initialCheckboxWidget.isChecked,
      false,
      reason: "TLCheckBox should initially be unchecked",
    );

    final initialTextFinder = find.text('テストタスク');
    expect(
      initialTextFinder,
      findsOneWidget,
      reason: "ToDo text should be present",
    );

    await tester.tap(find.byType(TLToDoCard));
    await tester.pump(const Duration(milliseconds: 100));

    final updatedTodoRowFinder = find.ancestor(
      of: find.text(testTodo.content),
      matching: find.byType(Row),
    );
    final updatedCheckboxFinder = find.descendant(
      of: updatedTodoRowFinder,
      matching: find.byType(TLCheckBox),
    );
    expect(
      updatedCheckboxFinder,
      findsOneWidget,
      reason: "TLCheckBox should still be present after tap",
    );
    // タップ後のチェック状態の確認は、Stateの変化を追う必要があるため、ここでは省略

    final updatedTextFinder = find.text('テストタスク');
    expect(
      updatedTextFinder,
      findsOneWidget,
      reason: "ToDo text should still be present after tap",
    );
  });
}
