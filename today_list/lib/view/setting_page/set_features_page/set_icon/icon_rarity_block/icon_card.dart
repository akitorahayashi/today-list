import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import 'package:today_list/model/external/tl_ads.dart';
import '../../../../../constants/global_keys.dart';
import '../../../../../alerts/yes_no_alert.dart';
import '../../../../../alerts/simple_alert.dart';
import '../../../../../constants/icon_for_checkbox_data.dart';
import '../../../../../model/tl_theme.dart';
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
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final bool isCurrentIcon =
        widget.iconCategoryName == SettingData.shared.defaultIconCategory &&
            widget.selectedIconRarity == SettingData.shared.defaultIconRarity &&
            widget.iconName == SettingData.shared.defaultIconName;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          if (TLAds.isPassActive || kDebugMode) {
            if (!isCurrentIcon) {
              SettingData.shared.askToSetDefaultIcon(
                  context: context,
                  iconCategoryName: widget.iconCategoryName,
                  iconRarity: widget.selectedIconRarity,
                  iconName: widget.iconName);
            }
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
                      corrThemeData: _tlThemeData,
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
          elevation: isCurrentIcon ? 0 : 3,
          color: _tlThemeData.panelColor,
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
                        : isCurrentIcon
                            ? iconsForCheckBox[widget.iconCategoryName]![widget
                                    .selectedIconRarity]![widget.iconName]!
                                .checkedIcon
                            : iconsForCheckBox[widget.iconCategoryName]![widget
                                    .selectedIconRarity]![widget.iconName]!
                                .notCheckedIcon,
                    color: !widget.isEarned
                        ? Colors.black26
                        : isCurrentIcon
                            ? _tlThemeData.checkmarkColor
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
                          : isCurrentIcon
                              ? _tlThemeData.checkmarkColor
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
