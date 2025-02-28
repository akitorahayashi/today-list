import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/external/tl_ads.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

class IconCard extends HookConsumerWidget {
  final bool showIfNotEarned;
  final TLIconCategory tlIconCategory;
  final TLIconName tlIconName;

  const IconCard({
    super.key,
    required this.showIfNotEarned,
    required this.tlIconCategory,
    required this.tlIconName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // selectedIcon を監視
    final selectedIcon = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlUserData.selectedCheckBoxIconData),
    );

    // earnedIcons の状態を監視
    final Map<String, List<String>> earnedCheckBoxIcons = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlUserData.earnedCheckBoxIcons),
    );

    // **現在のアイコンが獲得済みか判定**
    final bool isEarned =
        earnedCheckBoxIcons[tlIconCategory.name]?.contains(tlIconName.name) ??
            false;

    /// ユーザーが現在選択しているチェックアイコンかどうか判定
    bool isCurrentIcon = isEarned &&
        tlIconCategory.name == selectedIcon.iconCategory &&
        tlIconName.name == selectedIcon.iconName;

    /// アイコン選択時の挙動
    Future<void> onIconTap(BuildContext context) async {
      if (isCurrentIcon) return; // Already selected, do nothing

      if (!isEarned) {
        // Step 1: Show dialog and get the user's response
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return TLYesNoDialog(
              title: "Get Icon",
              message: "Do you want to watch a short video to earn this icon?",
              yesAction: () {
                Navigator.pop(dialogContext, true);
              },
            );
          },
        );

        if (confirmed != true || !context.mounted) {
          return; // User canceled or context is invalid
        }

        // Step 2: Show ProgressHUD
        ProgressHUD.of(context)?.show();

        // Step 3: Show the rewarded ad
        await TLAds.showIconRewardedAd(
          context: context,
          rewardAction: () async {
            if (!context.mounted) return; // Check if context is still valid

            // Step 4: Update the icon state
            ref.read(tlAppStateProvider.notifier)
              ..updateState(
                TLUserDataAction.updateEarnedIcons(
                  iconCategory: tlIconCategory,
                  iconName: tlIconName,
                ),
              )
              ..updateState(
                TLUserDataAction.updateSelectedCheckBoxIcon(
                  newCheckBox: SelectedCheckBoxIconData(
                    iconCategory: tlIconCategory.name,
                    iconName: tlIconName.name,
                  ),
                ),
              );

            // Step 5: Show success dialog
            if (context.mounted) {
              await const TLSingleOptionDialog(title: "Icon earned!")
                  .show(context: context);
            }
          },
        );

        // Step 6: Hide ProgressHUD
        if (context.mounted) {
          ProgressHUD.of(context)?.dismiss();
        }
      } else {
        // Icon is already earned, allow changing
        final bool? confirmed = await showDialog<bool>(
          context: context,
          builder: (dialogContext) {
            return TLYesNoDialog(
              title: "Change Icon",
              message: "Do you want to change the checkmark icon?",
              yesAction: () {
                Navigator.pop(dialogContext, true);
              },
            );
          },
        );

        if (confirmed != true || !context.mounted) return;

        // Update icon selection
        ref.read(tlAppStateProvider.notifier).updateState(
              TLUserDataAction.updateSelectedCheckBoxIcon(
                newCheckBox: SelectedCheckBoxIconData(
                  iconCategory: tlIconCategory.name,
                  iconName: tlIconName.name,
                ),
              ),
            );

        // Show success dialog
        if (context.mounted) {
          const TLSingleOptionDialog(title: "Change completed!")
              .show(context: context);
        }
      }
    }

    final TLThemeConfig themeConfig = TLTheme.of(context);
    final iconResource =
        iconResourceOfCheckBox[tlIconCategory.name]?[tlIconName.name];

    // 選択された場合は枠なし、未選択なら影をつける
    final double elevation = isCurrentIcon ? 0 : 3;
    final Color textColor = !isEarned
        ? Colors.black26
        : isCurrentIcon
            ? themeConfig.checkmarkColor
            : Colors.black45;

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => onIconTap(context),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: elevation,
          color: themeConfig.canTapCardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 4),
                  child: Icon(
                    (!isEarned && !showIfNotEarned)
                        ? Icons.help_outline
                        : isCurrentIcon
                            ? iconResource?.checkedIcon
                            : iconResource?.notCheckedIcon,
                    color: textColor,
                    size: 20,
                  ),
                ),
                Text(
                  (!isEarned && !showIfNotEarned) ? "???" : tlIconName.name,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
