import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/view/page/add_todo_page/already_exist/model_of_todo_card.dart';

void main() {
  // テスト用のモックデータを作成
  final mockWorkspace = TLWorkspace(
    id: 'workspace1',
    name: 'Test Workspace',
    workspaceIDToToDos: {},
  );

  final mockTodo = const TLToDo(
    id: 'todo1',
    workspaceID: 'workspace1',
    isInToday: true,
    content: 'Test Todo',
  );

  final mockTodoWithSteps = const TLToDo(
    id: 'todo2',
    workspaceID: 'workspace1',
    isInToday: true,
    content: 'Todo With Steps',
    steps: [
      TLStep(
        id: 'step1',
        content: 'Step 1',
        isChecked: false,
      ),
      TLStep(
        id: 'step2',
        content: 'Step 2',
        isChecked: true,
      ),
    ],
  );

  testWidgets('ModelOfToDoCard renders correctly without steps',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: ModelOfToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrTLToDo: mockTodo,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(ModelOfToDoCard), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.text('Test Todo'), findsOneWidget);
  });

  testWidgets('ModelOfToDoCard renders correctly with steps',
      (WidgetTester tester) async {
    // Build our widget with steps
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: ModelOfToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrTLToDo: mockTodoWithSteps,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(ModelOfToDoCard), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(3)); // Main card + 2 step cards
    expect(find.byType(TLCheckBox),
        findsNWidgets(3)); // Main checkbox + 2 step checkboxes
    expect(find.text('Todo With Steps'), findsOneWidget);
    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Step 2'), findsOneWidget);
  });

  testWidgets('ModelOfToDoCard handles checked state correctly',
      (WidgetTester tester) async {
    // Create a checked todo
    final checkedTodo = const TLToDo(
      id: 'todo3',
      workspaceID: 'workspace1',
      isInToday: true,
      isChecked: true,
      content: 'Checked Todo',
    );

    // Build our widget with checked todo
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: ModelOfToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrTLToDo: checkedTodo,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders with checked state
    expect(find.byType(ModelOfToDoCard), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);

    // Text should have reduced opacity when checked
    final textWidget = tester.widget<Text>(find.text('Checked Todo'));
    expect(textWidget.style?.color, Colors.black.withAlpha(77));
  });
}
