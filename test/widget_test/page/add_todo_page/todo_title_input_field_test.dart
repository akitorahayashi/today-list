import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/todo_title_input_field.dart';

void main() {
  testWidgets('ToDoタイトル入力フィールドが正しく表示される', (WidgetTester tester) async {
    final controller = TextEditingController();
    bool addButtonPressed = false;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
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
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('ToDo'), findsOneWidget);

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
      0.25,
    );

    await tester.enterText(find.byType(TextField), 'テストToDo');
    await tester.pump();

    expect(
      tester
          .widget<AnimatedOpacity>(
            find.ancestor(
              of: addButtonFinder,
              matching: find.byType(AnimatedOpacity),
            ),
          )
          .opacity,
      1.0,
    );

    await tester.tap(addButtonFinder);
    await tester.pump();

    expect(addButtonPressed, true);
  });

  testWidgets('入力内容の変更がUIに反映される', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: ToDoTitleInputField(
                toDoTitleController: controller,
                onCompleteEditing: () async {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'テストタイトル');
    await tester.pump();

    expect(find.text('テストタイトル'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    expect(find.text('テストタイトル'), findsNothing);
  });

  testWidgets('外部からのコントローラー更新がUIに反映される', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: ToDoTitleInputField(
                toDoTitleController: controller,
                onCompleteEditing: () async {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    controller.text = '外部からの更新';
    await tester.pump();

    expect(find.text('外部からの更新'), findsOneWidget);
  });
}
