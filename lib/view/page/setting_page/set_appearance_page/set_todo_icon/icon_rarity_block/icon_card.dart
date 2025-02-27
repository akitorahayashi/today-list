import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

class IconCard extends ConsumerStatefulWidget {
  final bool showIfNotEarned;
  final bool isEarned;
  final TLIconCategory tlIconCategory;
  final TLIconName tlIconName;

  const IconCard({
    super.key,
    required this.showIfNotEarned,
    required this.isEarned,
    required this.tlIconCategory,
    required this.tlIconName,
  });

  @override
  ConsumerState<IconCard> createState() => _IconCardState();
}

class _IconCardState extends ConsumerState<IconCard> {
  late final TLAppStateController _appStateController =
      ref.read(tlAppStateProvider.notifier);

  /// ユーザーが現在選択しているチェックアイコンかどうか判定
  bool get isCurrentIcon {
    if (!widget.isEarned) return false;
    final selectedIcon = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlUserData.selectedCheckBoxIconData),
    );
    return widget.tlIconCategory.name == selectedIcon.iconCategory &&
        widget.tlIconName.name == selectedIcon.iconName;
  }

  /// アイコン選択時の挙動
  Future<void> _onIconTap(BuildContext context) async {
    if (!widget.isEarned) {
      const TLSingleOptionDialog(title: "獲得してません").show(context: context);
      return;
    }

    if (isCurrentIcon) return;

    await TLYesNoDialog(
      title: "Change Icon",
      message: "Do you want to change\nthe checkmark icon?",
      yesAction: () async {
        Navigator.pop(context);
        await _appStateController.updateState(
          TLUserDataAction.updateSelectedCheckBoxIcon(
            newCheckBox: SelectedCheckBoxIconData(
              iconCategory: widget.tlIconCategory.name,
              iconName: widget.tlIconName.name,
            ),
          ),
        );
        if (context.mounted) {
          const TLSingleOptionDialog(title: "Change completed!")
              .show(context: context);
        }
      },
    ).show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig themeConfig = TLTheme.of(context);
    final iconResource = iconResourceOfCheckBox[widget.tlIconCategory.name]![
        widget.tlIconName.name];

    // 選択された場合は枠なし、未選択なら影をつける
    final double elevation = isCurrentIcon ? 0 : 3;
    final Color textColor = !widget.isEarned
        ? Colors.black26
        : isCurrentIcon
            ? themeConfig.checkmarkColor
            : Colors.black45;

    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => _onIconTap(context),
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
                    (!widget.isEarned && !widget.showIfNotEarned)
                        ? Icons.help_outline
                        : isCurrentIcon
                            ? iconResource?.checkedIcon
                            : iconResource?.notCheckedIcon,
                    color: textColor,
                    size: 20,
                  ),
                ),
                Text(
                  (!widget.isEarned && !widget.showIfNotEarned)
                      ? "???"
                      : widget.tlIconName.name,
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
