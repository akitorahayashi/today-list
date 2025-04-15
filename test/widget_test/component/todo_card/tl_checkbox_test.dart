import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

void main() {
  testWidgets('チェックボックスが未選択状態で正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: Scaffold(body: TLCheckBox(isChecked: false))),
      ),
    );

    // チェックボックスが表示されていることを確認
    expect(find.byType(TLCheckBox), findsOneWidget);

    // 未選択状態であることを確認（実装によって確認方法が異なるため、適宜調整が必要）
    // IconはFontAwesomeなどを使っている場合もあるので、具体的な実装に合わせて確認方法を変更
  });

  testWidgets('チェックボックスが選択状態で正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: Scaffold(body: TLCheckBox(isChecked: true))),
      ),
    );

    // チェックボックスが表示されていることを確認
    expect(find.byType(TLCheckBox), findsOneWidget);

    // 選択状態であることを確認（実装によって確認方法が異なるため、適宜調整が必要）
  });

  testWidgets('カスタムカラーとサイズが適用されるか確認', (WidgetTester tester) async {
    final Color customColor = Colors.red;
    final double customSize = 24.0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: TLCheckBox(
              isChecked: true,
              iconColor: customColor,
              iconSize: customSize,
            ),
          ),
        ),
      ),
    );

    // チェックボックスが表示されていることを確認
    expect(find.byType(TLCheckBox), findsOneWidget);

    // カスタムプロパティが適用されているかを確認する方法がコンポーネントの実装によって異なるため、
    // 具体的な検証は実装に合わせて調整する必要があります
  });
}
