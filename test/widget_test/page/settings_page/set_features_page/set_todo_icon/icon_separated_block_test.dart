import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/settings_page/set_features_page/set_todo_icon/icon_separated_block/icon_separated_block.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

void main() {
  // Flutter binding initialization
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    // Set up SharedPreferences mock
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('アイコン設定ブロックが正しく表示される', (WidgetTester tester) async {
    final iconsList = [TLIconName.circle];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: IconSeparatedBlock(
                showIfNotEarned: true,
                tlIconCategory: TLIconCategory.defaultCategory,
                icons: iconsList,
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle to avoid animation timing out
    await tester.pump();
    // Verify widget is found
    expect(find.byType(IconSeparatedBlock), findsOneWidget);
  });

  testWidgets('選択不可のアイコン設定ブロック表示テスト', (WidgetTester tester) async {
    final iconsList = [TLIconName.circle];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: IconSeparatedBlock(
                showIfNotEarned: false,
                tlIconCategory: TLIconCategory.defaultCategory,
                icons: iconsList,
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle to avoid animation timing out
    await tester.pump();
    expect(find.byType(IconSeparatedBlock), findsOneWidget);
  });

  testWidgets('複数のアイコンの表示テスト', (WidgetTester tester) async {
    final manyIcons = [TLIconName.circle, TLIconName.box];

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: TLTheme(
            data: TLThemeType.notebook.config,
            child: Scaffold(
              body: IconSeparatedBlock(
                showIfNotEarned: true,
                tlIconCategory: TLIconCategory.defaultCategory,
                icons: manyIcons,
              ),
            ),
          ),
        ),
      ),
    );

    // Use pump instead of pumpAndSettle to avoid animation timing out
    await tester.pump();
    expect(find.byType(IconSeparatedBlock), findsOneWidget);
  });
}
