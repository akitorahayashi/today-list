import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';

void main() {
  testWidgets('NumToDosCard renders correctly with title',
      (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: const NumToDosCard(
              title: 'In Today',
              numTodos: 5,
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders
    expect(find.byType(NumToDosCard), findsOneWidget);
    expect(find.byType(TLDoubleCard), findsOneWidget);
    expect(find.text('In Today'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
  });

  testWidgets('NumToDosCard renders correctly without title',
      (WidgetTester tester) async {
    // Build our widget with null title
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: const NumToDosCard(
              title: null,
              numTodos: 10,
            ),
          ),
        ),
      ),
    );

    // Verify the widget renders without title
    expect(find.byType(NumToDosCard), findsOneWidget);
    expect(find.byType(TLDoubleCard), findsOneWidget);
    expect(find.text('10'), findsOneWidget);

    // Title should not be found
    expect(find.text('In Today'), findsNothing);
  });

  testWidgets('NumToDosCard displays zero correctly',
      (WidgetTester tester) async {
    // Build our widget with zero todos
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: const NumToDosCard(
              title: 'In Whenever',
              numTodos: 0,
            ),
          ),
        ),
      ),
    );

    // Verify zero is displayed correctly
    expect(find.text('In Whenever'), findsOneWidget);
    expect(find.text('0'), findsOneWidget);
  });
}
