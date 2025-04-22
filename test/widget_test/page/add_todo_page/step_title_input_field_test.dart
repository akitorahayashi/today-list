import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/step_title_input_field.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';

void main() {
  testWidgets('ステップタイトル入力フィールドが正しく表示される', (WidgetTester tester) async {
    final controller = TextEditingController();
    String addedStepTitle = '';

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: StepTitleInputField(
                stepTitleController: controller,
                onAddOrEditStep: (title) {
                  addedStepTitle = title;
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Step'), findsOneWidget);

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

    await tester.enterText(find.byType(TextField), 'テストステップ');
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

    expect(addedStepTitle, 'テストステップ');
  });

  testWidgets('入力内容の変更がUIに反映される', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: StepTitleInputField(
                stepTitleController: controller,
                onAddOrEditStep: (title) {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'テストステップ');
    await tester.pump();

    expect(find.text('テストステップ'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.pump();

    expect(find.text('テストステップ'), findsNothing);
  });

  testWidgets('前の編集内容が入力欄に表示される', (WidgetTester tester) async {
    final controller = TextEditingController(text: '編集中のステップ');

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: StepTitleInputField(
                stepTitleController: controller,
                onAddOrEditStep: (title) {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('編集中のステップ'), findsOneWidget);

    final addButtonFinder = find.byIcon(Icons.add);
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
  });

  testWidgets('空白のみの入力では追加ボタンが有効にならない', (WidgetTester tester) async {
    final controller = TextEditingController();

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: StepTitleInputField(
                stepTitleController: controller,
                onAddOrEditStep: (title) {},
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '   ');
    await tester.pump();

    final addButtonFinder = find.byIcon(Icons.add);
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
  });
}
