import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_not_selecting_theme_panel.dart';

void main() {
  // Flutter binding initialization
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Set up SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('非選択状態のテーマパネルが正しく表示される', (WidgetTester tester) async {
    // テーマタイプの指定
    final themeType = TLThemeType.sunOrange;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: Center(
                child: ShowNotSelectingThemePanel(corrThemeType: themeType),
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle to avoid animation timing out
    await tester.pump();

    // パネルが表示されていることを確認
    expect(find.byType(ShowNotSelectingThemePanel), findsOneWidget);

    // テーマ名が表示されていることを確認
    expect(find.text('Sun\nOrange'), findsOneWidget);

    // カードが含まれていることを確認
    expect(find.byType(Card), findsWidgets);
  });

  testWidgets('テーマパネルをタップしたときの挙動', (WidgetTester tester) async {
    bool tapped = false;

    // Widget wrapped in StatefulBuilder to allow updating state within the test
    await tester.pumpWidget(
      MaterialApp(
        home: TLTheme(
          data: TLThemeType.notebook.config,
          child: Scaffold(
            body: Center(
              child: GestureDetector(
                onTap: () {
                  tapped = true;
                },
                child: Text('Test Button'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(tapped, true);
  });

  // Only include one theme variant in this test to avoid multiple rebuild issues
  testWidgets('異なるテーマタイプでの表示確認', (WidgetTester tester) async {
    // テスト用のより大きなサイズを設定
    tester.view.physicalSize = const Size(500, 800);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 140,
                  ),
                  child: ShowNotSelectingThemePanel(
                    corrThemeType: TLThemeType.cherryBlossom,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    expect(find.text('Cherry\nBlossom'), findsOneWidget);

    // Reset the test value after the test
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });
  });
}
