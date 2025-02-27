import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/redux/action/tl_checkbox_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'package:today_list/service/tl_vibration.dart';

class IconCard extends ConsumerStatefulWidget {
  final bool isEarned;
  final TLIconCategory tlIconCategory;
  final TLIconName tlIconName;
  const IconCard({
    super.key,
    required this.isEarned,
    required this.tlIconCategory,
    required this.tlIconName,
  });

  @override
  ConsumerState<IconCard> createState() => _IconCardState();
}

class _IconCardState extends ConsumerState<IconCard> {
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final SelectedCheckBoxIconData selectedCheckBoxIconData = ref.watch(
        tlAppStateProvider.select((state) => state.selectedCheckBoxIconData));
    final TLAppStateController tlAppStateController =
        ref.read(tlAppStateProvider.notifier);
    final bool isCurrentIcon =
        widget.tlIconCategory.name == selectedCheckBoxIconData.iconCategory &&
            widget.tlIconName.name == selectedCheckBoxIconData.iconName;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          if (!isCurrentIcon) {
            await TLYesNoDialog(
                title: "Change Icon",
                message: "Do you want to change\nthe checkmark icon?",
                yesAction: () async {
                  Navigator.pop(context);
                  tlAppStateController.updateState(
                      TLCheckBoxAction.updateSelectedIcon(
                          newCheckBox: SelectedCheckBoxIconData(
                              iconCategory: widget.tlIconCategory.name,
                              iconName: widget.tlIconName.name)));
                  const TLSingleOptionDialog(title: "Change completed!")
                      .show(context: context);
                  TLVibrationService.vibrate();
                }).show(context: context);

            // SettingData.shared.askToSetDefaultIcon(
            //     context: context,
            //     iconCategoryName: widget.iconCategoryName,
            //     iconRarity: widget.selectedIconRarity,
            //     iconName: widget.iconName);
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: isCurrentIcon ? 0 : 3,
          color: tlThemeConfig.canTapCardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, bottom: 4),
                  child: Icon(
                    !widget.isEarned
                        ? Icons.help_outline
                        : isCurrentIcon
                            ? tlIconResource[widget.tlIconCategory.name]![
                                    widget.tlIconName.name]!
                                .checkedIcon
                            : tlIconResource[widget.tlIconCategory.name]![
                                    widget.tlIconName.name]!
                                .notCheckedIcon,
                    color: !widget.isEarned
                        ? Colors.black26
                        : isCurrentIcon
                            ? tlThemeConfig.checkmarkColor
                            : Colors.black45,
                    size: 20,
                  ),
                ),
                Text(
                  !widget.isEarned ? "???" : widget.tlIconName.name,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: !widget.isEarned
                          ? Colors.black26
                          : isCurrentIcon
                              ? tlThemeConfig.checkmarkColor
                              : Colors.black45),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
