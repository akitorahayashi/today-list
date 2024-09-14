import 'package:flutter/material.dart';
import 'package:today_list/model/externals/tl_ads.dart';
import '../../../../../constants/global_keys.dart';
import '../../../../../alerts/common/yes_no_alert.dart';
import '../../../../../alerts/common/simple_alert.dart';
import '../../../../../constants/icon_for_checkbox.dart';
import '../../../../../constants/theme.dart';
import '../../../../../model/user/setting_data.dart';

class IconCard extends StatefulWidget {
  final bool isEarned;
  final String iconCategoryName;
  final String selectedIconRarity;
  final String iconName;
  const IconCard({
    super.key,
    required this.isEarned,
    required this.iconCategoryName,
    required this.selectedIconRarity,
    required this.iconName,
  });

  @override
  State<IconCard> createState() => _IconCardState();
}

class _IconCardState extends State<IconCard> {
  bool get isFontawesomeCategories =>
      fontawesomeCategories.contains(widget.iconCategoryName);

  @override
  Widget build(BuildContext context) {
    final bool isFocused =
        widget.iconCategoryName == settingData.defaultIconCategory &&
            widget.selectedIconRarity == settingData.defaultIconRarity &&
            widget.iconName == settingData.defaultIconName;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          if (TLAds.isPassActive) {
            settingData.askToSetDefaultIcon(
                context: context,
                iconCategoryName: widget.iconCategoryName,
                iconRarity: widget.selectedIconRarity,
                iconName: widget.iconName);
          } else {
            await yesNoAlert(
              context: context,
              title: "PASSを獲得しよう!",
              message:
                  "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
              yesAction: () => TLAds.showRewardedAd(
                context: context,
                rewardAction: () {
                  TLAds.extendLimitOfPassReward(howManyDays: 3);
                  simpleAlert(
                      context: context,
                      title: "PASSが延長されました!",
                      message: "3日分のPASSを獲得しました",
                      buttonText: "OK");
                  setAppearancePageKey.currentState?.setState(() {});
                },
              ),
            );
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: isFocused ? 0 : 3,
          color: theme[settingData.selectedTheme]!.panelColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: isFontawesomeCategories ? 3 : 0,
                      bottom: isFontawesomeCategories ? 4 : 2.0),
                  child: Icon(
                    !widget.isEarned
                        ? Icons.help_outline
                        : isFocused
                            ? iconsForCheckBox[widget.iconCategoryName]![widget
                                    .selectedIconRarity]![widget.iconName]!
                                .checkedIcon
                            : iconsForCheckBox[widget.iconCategoryName]![widget
                                    .selectedIconRarity]![widget.iconName]!
                                .notCheckedIcon,
                    color: !widget.isEarned
                        ? Colors.black26
                        : isFocused
                            ? theme[settingData.selectedTheme]!.checkmarkColor
                            : Colors.black45,
                    size: isFontawesomeCategories ? 17 : 20,
                  ),
                ),
                Text(
                  !widget.isEarned ? "???" : widget.iconName,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: !widget.isEarned
                          ? Colors.black26
                          : isFocused
                              ? theme[settingData.selectedTheme]!.checkmarkColor
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
