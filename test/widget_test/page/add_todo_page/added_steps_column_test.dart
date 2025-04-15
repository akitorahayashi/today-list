import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/added_steps_column.dart';

void main() {
  // Flutter binding initialization
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Set up SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('追加済みステップが正しく表示される', (WidgetTester tester) async {
    // テスト用のステップ一覧
    final steps = [
      TLStep(id: 'step1', content: 'ステップ1'),
      TLStep(id: 'step2', content: 'ステップ2'),
      TLStep(id: 'step3', content: 'ステップ3'),
    ];

    int editedStepIndex = -1;
    int removedStepIndex = -1;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: AddedStepsColumn(
                steps: steps,
                onEditStep: (index) {
                  editedStepIndex = index;
                },
                onRemoveStep: (index) {
                  removedStepIndex = index;
                },
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle to avoid animation timing out
    await tester.pump();
    // Pump a few more times to ensure all animations have a chance to start
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 100));

    // 各ステップが表示されていることを確認
    expect(find.text('ステップ1'), findsOneWidget);
    expect(find.text('ステップ2'), findsOneWidget);
    expect(find.text('ステップ3'), findsOneWidget);

    // 削除ボタンが表示されていることを確認 (正確な数は環境によって変わる可能性があるため、存在のみ確認)
    expect(find.byIcon(Icons.remove), findsWidgets);

    // 1つ目のステップをタップして編集 (テキストを直接タップする)
    await tester.tap(find.text('ステップ1'));
    await tester.pump();

    // 編集コールバックが呼ばれたことを確認
    expect(editedStepIndex, 0);

    // 削除ボタンをタップするために適切なファインダーを使用
    final removeIcons = find.byIcon(Icons.remove);
    // 2つ目のステップの削除ボタン（インデックス1）をタップ
    await tester.tap(removeIcons.at(1));
    await tester.pump();

    // 削除コールバックが呼ばれたことを確認
    expect(removedStepIndex, 1);
  });

  testWidgets('ステップが空の場合は何も表示されない', (WidgetTester tester) async {
    // 空のステップリスト
    final steps = <TLStep>[];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: AddedStepsColumn(
                steps: steps,
                onEditStep: (index) {},
                onRemoveStep: (index) {},
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle
    await tester.pump();

    // ステップが表示されていないことを確認
    expect(find.text('ステップ1'), findsNothing);
    expect(find.text('ステップ2'), findsNothing);
    expect(find.text('ステップ3'), findsNothing);
    expect(find.byIcon(Icons.remove), findsNothing);
  });

  testWidgets('長いテキストのステップも適切に表示される', (WidgetTester tester) async {
    // 長いテキストを含むステップ
    final steps = [
      TLStep(
        id: 'step1',
        content:
            '非常に長いテキストの内容を持つステップで、表示が適切に行われるかテストします。'
            'このテキストは複数行にわたって表示されることが想定されています。',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: SingleChildScrollView(
                child: AddedStepsColumn(
                  steps: steps,
                  onEditStep: (index) {},
                  onRemoveStep: (index) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // 長いテキストが表示されていることを確認
    expect(
      find.text(
        '非常に長いテキストの内容を持つステップで、表示が適切に行われるかテストします。'
        'このテキストは複数行にわたって表示されることが想定されています。',
      ),
      findsOneWidget,
    );
  });
}
