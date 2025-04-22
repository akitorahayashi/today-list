import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_selecting_theme_panel.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_not_selecting_theme_panel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  testWidgets('現在選択中のテーマパネルが正しく表示される', (WidgetTester tester) async {
    final themeType = TLThemeType.sunOrange;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: themeType.config,
          child: MaterialApp(home: Scaffold(body: ShowSelectingThemePanel())),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final containerFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(containerFinder.first);
    expect(
      (containerWidget.decoration as BoxDecoration).gradient,
      themeType.config.gradientOfNavBar,
    );

    final cardFinder = find.byType(Card);
    final cardWidget = tester.widget<Card>(cardFinder.first);
    expect(cardWidget.color, themeType.config.canTapCardColor);

    final textFinder = find.text('Sun\nOrange');
    expect(textFinder, findsOneWidget);
    final textStyle =
        tester.renderObject<RenderParagraph>(textFinder).text.style;
    expect(textStyle?.color, themeType.config.accentColor);

    expect(find.byIcon(FontAwesomeIcons.solidSquareCheck), findsOneWidget);
  });

  testWidgets('選択可能なテーマパネルが正しく表示される', (WidgetTester tester) async {
    final themeType = TLThemeType.limeGreen;

    await tester.pumpWidget(
      ProviderScope(
        child: AnimatedTLTheme(
          data: TLThemeType.notebook.config,
          child: MaterialApp(
            home: Scaffold(
              body: ShowNotSelectingThemePanel(corrThemeType: themeType),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    final containerFinder = find.byType(Container);
    final containerWidget = tester.widget<Container>(containerFinder.first);
    expect(
      (containerWidget.decoration as BoxDecoration).gradient,
      themeType.config.gradientOfNavBar,
    );

    final cardFinder = find.byType(Card);
    final cardWidget = tester.widget<Card>(cardFinder.first);
    expect(cardWidget.color, themeType.config.canTapCardColor);

    final textFinder = find.text('Lime\nGreen');
    expect(textFinder, findsOneWidget);
    final textStyle =
        tester.renderObject<RenderParagraph>(textFinder).text.style;
    expect(textStyle?.color, themeType.config.accentColor);

    expect(find.byIcon(Icons.check), findsNothing);
  });

  testWidgets('テーマパネルをタップしたときの挙動', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: ShowNotSelectingThemePanel(
              corrThemeType: TLThemeType.limeGreen,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(ShowNotSelectingThemePanel));
    await tester.pumpAndSettle();
  });

  testWidgets('テーマパネルの視覚的なスタイル確認', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: Container(
              color: Colors.white,
              child: ShowNotSelectingThemePanel(
                corrThemeType: TLThemeType.limeGreen,
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Card), findsWidgets);
  });
}
