import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/view/page/setting_page/set_features_page/panel_with_title.dart';
import 'package:today_list/view/page/setting_page/set_features_page/update_app_icon_card.dart';
import 'theme_panel/left_side_show_selecting_panel.dart';
import 'theme_panel/right_side_theme_select_button.dart';
import 'set_todo_icon/icon_category_panel.dart';
import 'set_vibration_card.dart';

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
        // THEME選択カード
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: PanelWithTitle(title: "THEME", contents: [
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const LeftSideShowingSelectingPanel(),
                        SizedBox(
                          height: 320,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RightSideThemeSelectButton(
                                  corrThemeType: unUsingThemes[0]),
                              RightSideThemeSelectButton(
                                  corrThemeType: unUsingThemes[1]),
                            ],
                          ),
                        ),
                      ]),
                  const UpdateAppIconCard()
                ],
              ),
            ),
          ]),
        ),
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
