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

  const uncheckedStep = TLStep(
    id: 'step1',
    content: 'Unchecked Step',
    isChecked: false,
  );

  const checkedStep = TLStep(
    id: 'step2',
    content: 'Checked Step',
    isChecked: true,
  );

  testWidgets('TLStepCard renders correctly when unchecked',
      (WidgetTester tester) async {
    // Build our widget with unchecked step
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLStepCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                corrStep: uncheckedStep,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(TLStepCard), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.text('Unchecked Step'), findsOneWidget);

    // Find the text widget and verify its style
    final textWidget = tester.widget<Text>(find.text('Unchecked Step'));
    expect(textWidget.style!.color!.alpha / 255, closeTo(0.6, 0.01));
  });

  testWidgets('TLStepCard renders correctly when checked',
      (WidgetTester tester) async {
    // Build our widget with checked step
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLStepCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                corrStep: checkedStep,
              ),
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(TLStepCard), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.text('Checked Step'), findsOneWidget);

    // Find the text widget and verify its style (reduced opacity when checked)
    final textWidget = tester.widget<Text>(find.text('Checked Step'));
    expect(textWidget.style!.color!.alpha / 255, closeTo(0.3, 0.01));
  });

  testWidgets('TLStepCard has correct font size and weight',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLTheme(
              data: TLThemeType.sunOrange.config,
              child: TLStepCard(
                ifInToday: true,
                corrWorkspace: mockWorkspace,
                corrToDo: mockTodo,
                corrStep: uncheckedStep,
              ),
            ),
          ),
        ),
      ),
    );

    // Find the text widget and verify its style properties
    final textWidget = tester.widget<Text>(find.text('Unchecked Step'));
    expect(textWidget.style?.fontSize, 12.0);
    expect(textWidget.style?.fontWeight, FontWeight.w600);
  });
}
