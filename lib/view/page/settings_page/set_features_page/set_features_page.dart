import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/settings_page/set_features_page/panel_with_title.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'theme_panel/show_selecting_theme_panel.dart'
    show ShowSelectingThemePanel;
import 'theme_panel/show_not_selecting_theme_panel.dart';
import 'theme_panel/accent_color_selector.dart';
import 'set_todo_icon/icon_category_panel.dart';
import 'set_vibration_card.dart';

import 'package:flutter_progress_hud/flutter_progress_hud.dart';

class SetFeaturesPage extends HookConsumerWidget {
  const SetFeaturesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeType selectedThemeType = ref
        .watch(tlAppStateProvider.select((state) => state.selectedThemeType));

    List<TLThemeType> unUsingThemes = TLThemeType.values
        .where((theme) => theme != selectedThemeType)
        .toList();

    return ProgressHUD(
      barrierEnabled: true,
      indicatorColor: Colors.white,
      indicatorWidget: const Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(height: 24),
            Text(
              "Loading...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
      child: ListView(padding: EdgeInsets.zero, children: [
        // テーマ選択パネル
        PanelWithTitle(
          title: "THEME",
          contents: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  // 現在選択中のテーマを表示
                  Container(
                    height: 180,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const ShowSelectingThemePanel(),
                  ),
                  const SizedBox(height: 16),

                  // 他のテーマを選択するボタン - スクロール可能なリスト
                  Container(
                    height: 120,
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: unUsingThemes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ShowNotSelectingThemePanel(
                            corrThemeType: unUsingThemes[index],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const PanelWithTitle(title: "Accent Color", contents: [
          AccentColorSelector(),
        ]),
        const PanelWithTitle(
            title: "VIBRATION", contents: [SetVibrationCard()]),
        PanelWithTitle(
          title: "ICONS",
          contents: [
            for (TLIconCategory tlIconCategory in [
              TLIconCategory.defaultCategory,
              TLIconCategory.unit1,
              TLIconCategory.unit2,
            ])
              IconCategoryPanel(corrIconCategory: tlIconCategory),
          ],
        ),
        const SizedBox(height: 250),
      ]),
    );
  }
}
