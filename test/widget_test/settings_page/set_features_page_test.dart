import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';
import 'package:today_list/view/page/settings_page/set_features_page/panel_with_title.dart';
import 'package:today_list/view/page/settings_page/set_features_page/set_features_page.dart';
import 'package:today_list/view/page/settings_page/set_features_page/set_vibration_card/set_vibration_card.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_selecting_theme_panel.dart';
import 'package:today_list/view/page/settings_page/set_features_page/theme_panel/show_not_selecting_theme_panel.dart';
import 'package:today_list/view/page/settings_page/set_features_page/set_todo_icon/icon_category_panel.dart';

void main() {
  group('SetFeaturesPage Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer(
        overrides: [
          tlAppStateProvider.overrideWith(() => MockTLAppStateController()),
        ],
      );
    });

    Widget buildTestableWidget(Widget child) {
      return ProviderScope(
        child: UncontrolledProviderScope(
          container: container,
          child: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: MaterialApp(
              home: Scaffold(
                body: child,
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('SetFeaturesPage has correct structure',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const SetFeaturesPage()));
      await tester.pumpAndSettle(); // アニメーションが完了するまで待機

      // 基本構造の検証
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(PanelWithTitle), findsNWidgets(2)); // THEME, VIBRATION
    });

    testWidgets('PanelWithTitle has correct structure',
        (WidgetTester tester) async {
      const String testTitle = 'TEST PANEL';
      final List<Widget> testContents = [
        const Text('Test Content'),
      ];

      await tester.pumpWidget(buildTestableWidget(
        PanelWithTitle(
          title: testTitle,
          contents: testContents,
        ),
      ));

      expect(find.text(testTitle), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(2)); // 外側と内側のカード
    });

    testWidgets('SetVibrationCard has slider and labels',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(const SetVibrationCard()));

      expect(find.byType(Slider), findsOneWidget);
      expect(find.text('なし'), findsOneWidget);
      expect(find.text('最大'), findsOneWidget);
    });

    testWidgets('LeftSideShowingSelectingPanel has correct structure',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(buildTestableWidget(const ShowSelectingThemePanel()));

      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('RightSideThemeSelectButton displays theme title',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        const ShowNotSelectingThemePanel(
          corrThemeType: TLThemeType.limeGreen,
        ),
      ));

      expect(find.text(TLThemeType.limeGreen.config.themeTitleInSettings),
          findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('IconCategoryPanel displays category name',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestableWidget(
        const IconCategoryPanel(
          corrIconCategory: TLIconCategory.defaultCategory,
        ),
      ));

      expect(find.text(TLIconCategory.defaultCategory.name), findsOneWidget);
    });
  });
}

// モックのTLAppStateController
class MockTLAppStateController extends TLAppStateController {
  @override
  TLAppState build() {
    return const TLAppState(
      selectedThemeType: TLThemeType.sunOrange,
    );
  }

  @override
  Future<void> updateState(dynamic action) async {
    // テスト用に何もしない
  }
}
