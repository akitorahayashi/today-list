import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/view/component/todo_card/tl_step_card.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card/tl_todo_card.dart';

void main() {
  // テスト用のモックデータを作成
  final mockWorkspace = TLWorkspace(
    id: 'workspace1',
    name: 'Test Workspace',
    workspaceIDToToDos: {},
  );

  const mockTodo = TLToDo(
    id: 'todo1',
    workspaceID: 'workspace1',
    isInToday: true,
    content: 'Test Todo',
  );

  const mockTodoWithSteps = TLToDo(
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

  const checkedTodo = TLToDo(
    id: 'todo3',
    workspaceID: 'workspace1',
    isInToday: true,
    isChecked: true,
    content: 'Checked Todo',
  );

  testWidgets('TLToDoCard renders correctly without steps',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(TLToDoCard), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.text('Test Todo'), findsOneWidget);

    // Verify no steps are displayed
    expect(find.byType(TLStepCard), findsNothing);
  });

  testWidgets('TLToDoCard renders correctly with steps',
      (WidgetTester tester) async {
    // Build our widget with steps
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodoWithSteps,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(TLToDoCard), findsOneWidget);
    expect(find.text('Todo With Steps'), findsOneWidget);

    // Verify steps are displayed
    expect(find.byType(TLStepCard), findsNWidgets(2));
    expect(find.text('Step 1'), findsOneWidget);
    expect(find.text('Step 2'), findsOneWidget);
  });

  testWidgets('TLToDoCard handles checked state correctly',
      (WidgetTester tester) async {
    // Build our widget with checked todo
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLToDoCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: checkedTodo,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders with checked state
    expect(find.byType(TLToDoCard), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);

    // Find the text widget and verify its style
    final textWidget = tester.widget<Text>(find.text('Checked Todo'));
    expect(textWidget.style?.color?.opacity, closeTo(0.3, 0.01));
  });
}
