import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/create_tcw_settings_card/add_tcw_button.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/create_tcw_settings_card/create_tcw_settings_card.dart';
import 'package:today_list/view/page/setting_page/tcw_settings_page/tcw_card_list/card_list_of_todos_in_category_settings.dart';
import 'package:today_list/service/tl_vibration.dart';

class TCWSettingsPage extends HookConsumerWidget {
  final ValueNotifier<bool> showBottomNavBar;

  TCWSettingsPage({super.key, required this.showBottomNavBar});

  // tcw追加ボタンを表示するか、入力フォームとの切り替え
  final _showAddWKSButton = useState<bool>(true);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 設定済みのWidgetExtensionを表示
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: CardListOfToDosInCategoryWidgetSettings(),
        ),
        // 新たにWidgetExtensionを追加
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              // +マーク
              firstChild: AddToDosInCategoryWidgetSettingsButton(onPressed: () {
                TLVibrationService.vibrate();
                _showAddWKSButton.value = false;
              }),
              secondChild: CreateWKSettingsCard(
                showAddWKSButtonAction: () {
                  _showAddWKSButton.value = true;
                },
                showBottomNavBar: showBottomNavBar,
              ),
              crossFadeState: _showAddWKSButton.value
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
        ),
        // スペーサー
        const SizedBox(height: 250),
      ],
    );
  }
}
