import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';

// Mock TLAppStateController for testing
class MockTLAppStateController extends StateNotifier<TLAppState> {
  MockTLAppStateController()
      : super(const TLAppState(
          tlWorkspaces: [],
          currentWorkspaceID: null,
          selectedThemeType: TLThemeType.sunOrange,
          tlUserData: TLUserData(
            currentAppIconName: "Sun Orange",
            selectedCheckBoxIconData: SelectedCheckBoxIconData(
              iconCategory: "Default",
              iconName: "Box",
            ),
            earnedCheckBoxIcons: {
              "Default": ["Box", "Circle"]
            },
          ),
        ));
}

void main() {
  // テスト用のウィジェットをラップするヘルパー関数
  Widget buildTestWidget({
    required Widget child,
    bool isChecked = false,
    Color? iconColor,
    double? iconSize,
  }) {
    return ProviderScope(
      // テスト用のProviderScopeを使用
      child: MaterialApp(
        home: Scaffold(
          body: TLTheme(
            data: TLThemeType.sunOrange.config,
            child: TLCheckBox(
              isChecked: isChecked,
              iconColor: iconColor,
              iconSize: iconSize,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('TLCheckBox renders correctly when checked',
      (WidgetTester tester) async {
    // Build our widget with checked state
    await tester.pumpWidget(buildTestWidget(
      child: const TLCheckBox(isChecked: true),
      isChecked: true,
    ));

    // Verify the widget renders
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('TLCheckBox renders correctly when unchecked',
      (WidgetTester tester) async {
    // Build our widget with unchecked state
    await tester.pumpWidget(buildTestWidget(
      child: const TLCheckBox(isChecked: false),
      isChecked: false,
    ));

    // Verify the widget renders
    expect(find.byType(TLCheckBox), findsOneWidget);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('TLCheckBox respects custom icon color and size',
      (WidgetTester tester) async {
    // Build our widget with custom color and size
    await tester.pumpWidget(buildTestWidget(
      child: const TLCheckBox(
        isChecked: true,
        iconColor: Colors.purple,
        iconSize: 24.0,
      ),
      isChecked: true,
      iconColor: Colors.purple,
      iconSize: 24.0,
    ));

    // Get the icon widget and verify its custom properties
    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.color, Colors.purple);
    expect(icon.size, 24.0);
  });
}
