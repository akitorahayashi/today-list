import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/add_todo_page/already_exist/already_exist.dart';
import 'package:today_list/view/page/add_todo_page/already_exist/model_of_todo_card.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';

void main() {
  // テスト用のモックデータを作成
  final mockWorkspace = TLWorkspace(
    id: 'workspace1',
    name: 'Test Workspace',
    workspaceIDToToDos: {
      'workspace1': const TLToDosInTodayAndWhenever(
        workspaceID: 'workspace1',
        toDosInToday: [
          TLToDo(
            id: 'todo1',
            workspaceID: 'workspace1',
            isInToday: true,
            content: 'Today Task 1',
          ),
          TLToDo(
            id: 'todo2',
            workspaceID: 'workspace1',
            isInToday: true,
            content: 'Today Task 2',
            steps: [
              TLStep(
                id: 'step1',
                content: 'Step 1',
                isChecked: false,
              ),
            ],
          ),
        ],
        toDosInWhenever: [
          TLToDo(
            id: 'todo3',
            workspaceID: 'workspace1',
            isInToday: false,
            content: 'Whenever Task 1',
          ),
        ],
      ),
    },
  );

  testWidgets('AlreadyExist renders correctly with todos',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: AlreadyExist(
                corrWorkspace: mockWorkspace,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(AlreadyExist), findsOneWidget);

    // Verify the NumToDosCard widgets
    expect(find.byType(NumToDosCard), findsNWidgets(2));
    expect(find.text('In Today'), findsOneWidget);
    expect(find.text('In Whenever'), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // 2 today tasks
    expect(find.text('1'), findsOneWidget); // 1 whenever task

    // Verify the todo cards
    expect(find.byType(ModelOfToDoCard), findsNWidgets(3)); // 3 total tasks
    expect(find.text('Today Task 1'), findsOneWidget);
    expect(find.text('Today Task 2'), findsOneWidget);
    expect(find.text('Whenever Task 1'), findsOneWidget);

    // Verify the step is displayed
    expect(find.text('Step 1'), findsOneWidget);
  });

  testWidgets('AlreadyExist handles empty todo lists',
      (WidgetTester tester) async {
    // Create a workspace with empty todo lists
    final emptyWorkspace = TLWorkspace(
      id: 'workspace1',
      name: 'Test Workspace',
      workspaceIDToToDos: {
        'workspace1': const TLToDosInTodayAndWhenever(
          workspaceID: 'workspace1',
          toDosInToday: [],
          toDosInWhenever: [],
        ),
      },
    );

    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: AlreadyExist(
                corrWorkspace: emptyWorkspace,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(AlreadyExist), findsOneWidget);

    // Verify the NumToDosCard widgets
    expect(find.byType(NumToDosCard), findsNWidgets(2));
    expect(find.text('In Today'), findsOneWidget);
    expect(find.text('In Whenever'), findsOneWidget);
    expect(find.text('0'), findsNWidgets(2)); // Both should show 0

    // Verify no todo cards are displayed
    expect(find.byType(ModelOfToDoCard), findsNothing);
  });
}
