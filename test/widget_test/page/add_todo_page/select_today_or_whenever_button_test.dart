import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/select_today_or_whenever_button.dart';

void main() {
  testWidgets('Today/Wheneverボタンが初期状態で正しく表示される', (WidgetTester tester) async {
    bool isToday = true;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: SelectTodayOrWheneverButton(
                ifInToday: isToday,
                onChanged: (value) {
                  isToday = value;
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final toggleButtonsFinder = find.byType(ToggleButtons);
    expect(toggleButtonsFinder, findsOneWidget);

    final toggleWidget = tester.widget<ToggleButtons>(toggleButtonsFinder);
    expect(toggleWidget.isSelected[0], true);
    expect(toggleWidget.isSelected[1], false);
  });

  testWidgets('ボタンを押した時に正しく切り替わることを確認', (WidgetTester tester) async {
    bool isToday = true;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: StatefulBuilder(
                builder: (context, setState) {
                  return SelectTodayOrWheneverButton(
                    ifInToday: isToday,
                    onChanged: (value) {
                      setState(() {
                        isToday = value;
                      });
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.tap(find.text(' いつでも '));
    await tester.pumpAndSettle();

    final toggleButtonsFinder = find.byType(ToggleButtons);
    final toggleWidget = tester.widget<ToggleButtons>(toggleButtonsFinder);
    expect(toggleWidget.isSelected[0], false);
    expect(toggleWidget.isSelected[1], true);
    expect(isToday, false);

    await tester.tap(find.text('今日'));
    await tester.pumpAndSettle();

    final updatedToggleWidget = tester.widget<ToggleButtons>(
      toggleButtonsFinder,
    );
    expect(updatedToggleWidget.isSelected[0], true);
    expect(updatedToggleWidget.isSelected[1], false);
    expect(isToday, true);
  });

  testWidgets('初期状態で「いつでも」を選択した場合のテスト', (WidgetTester tester) async {
    bool isToday = false;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: SelectTodayOrWheneverButton(
                ifInToday: isToday,
                onChanged: (value) {
                  isToday = value;
                },
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final toggleButtonsFinder = find.byType(ToggleButtons);
    expect(toggleButtonsFinder, findsOneWidget);

    final toggleWidget = tester.widget<ToggleButtons>(toggleButtonsFinder);
    expect(toggleWidget.isSelected[0], false);
    expect(toggleWidget.isSelected[1], true);
  });
}
