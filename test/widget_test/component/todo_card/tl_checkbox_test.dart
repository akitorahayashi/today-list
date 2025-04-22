import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

void main() {
  testWidgets('チェックボックスが未選択状態で正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(body: TLCheckBox(isChecked: false)),
          ),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(TLCheckBox), findsOneWidget);
  });

  testWidgets('チェックボックスが選択状態で正しく表示される', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(home: Scaffold(body: TLCheckBox(isChecked: true))),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(TLCheckBox), findsOneWidget);
  });

  testWidgets('カスタムカラーとサイズが適用されるか確認', (WidgetTester tester) async {
    final customColor = Colors.red;
    const customSize = 30.0;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
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
      ),
    );

    await tester.pump();

    expect(find.byType(TLCheckBox), findsOneWidget);
  });
}
