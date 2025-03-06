import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card/slidable_for_todo_card.dart';

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

  const checkedTodo = TLToDo(
    id: 'todo2',
    workspaceID: 'workspace1',
    isInToday: true,
    isChecked: true,
    content: 'Checked Todo',
  );

  testWidgets('SlidableForToDoCard renders correctly with child widget',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: SlidableForToDoCard(
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                child: const Text('Child Widget'),
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(SlidableForToDoCard), findsOneWidget);
    expect(find.byType(Slidable), findsOneWidget);
    expect(find.text('Child Widget'), findsOneWidget);
  });

  testWidgets('SlidableForToDoCard is enabled for unchecked todos',
      (WidgetTester tester) async {
    // Build our widget with unchecked todo
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: SlidableForToDoCard(
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                child: const Text('Unchecked Todo'),
              ),
            ),
          ),
        ),
      ),
    );

    // Find the Slidable widget and verify it's enabled
    final slidable = tester.widget<Slidable>(find.byType(Slidable));
    expect(slidable.enabled, true);
  });

  testWidgets('SlidableForToDoCard is disabled for checked todos',
      (WidgetTester tester) async {
    // Build our widget with checked todo
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: SlidableForToDoCard(
                corrWorkspace: mockWorkspace,
                corrToDo: checkedTodo,
                child: const Text('Checked Todo'),
              ),
            ),
          ),
        ),
      ),
    );

    // Find the Slidable widget and verify it's disabled
    final slidable = tester.widget<Slidable>(find.byType(Slidable));
    expect(slidable.enabled, false);
  });

  testWidgets('SlidableForToDoCard has correct action pane',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: SlidableForToDoCard(
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                child: const Text('Test Todo'),
              ),
            ),
          ),
        ),
      ),
    );

    // Find the Slidable widget and verify it has an end action pane
    final slidable = tester.widget<Slidable>(find.byType(Slidable));
    expect(slidable.endActionPane, isNotNull);
  });
}
