import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/component/todo_card/tl_checkbox.dart';
import 'package:today_list/model/design/icon_data/selected_icon_data.dart';
import 'package:today_list/model/design/icon_data/sid_provider.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import '../../../../../component/dialog/common/tl_single_option_dialog.dart';
import '../../../../../component/dialog/common/tl_yes_no_dialog.dart';
import '../../../../../model/external/tl_ads.dart';
import '../../../../../model/design/icon_data/icon_for_checkbox.dart';
import '../../../../../model/design/tl_theme.dart';
import '../../../../../main.dart';

class IconCard extends ConsumerStatefulWidget {
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
  ConsumerState<IconCard> createState() => _IconCardState();
}

class _IconCardState extends ConsumerState<IconCard> {
  bool get isFontawesomeCategories =>
      fontawesomeCategories.contains(widget.iconCategoryName);

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final TLIconData tlIconData = ref.watch(tlIconDataProvider);
    final bool isCurrentIcon = widget.iconCategoryName == tlIconData.category &&
        widget.selectedIconRarity == tlIconData.rarity &&
        widget.iconName == tlIconData.name;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          if (TLAds.isPassActive || kDebugMode) {
            if (!isCurrentIcon) {
              TLYesNoDialog(
                  title: "アイコンの変更",
                  message: "チェックマークのアイコンを\n変更しますか?",
                  yesAction: () {
                    Navigator.pop(context);
                    // TODO アイコンを変更する処理
                    TLVibration.vibrate();
                    const TLSingleOptionDialog(title: "変更が完了しました!")
                        .show(context: context);
                  }).show(context: context);
              // SettingData.shared.askToSetDefaultIcon(
              //     context: context,
              //     iconCategoryName: widget.iconCategoryName,
              //     iconRarity: widget.selectedIconRarity,
              //     iconName: widget.iconName);
            }
          } else {
            await TLYesNoDialog(
              title: "PASSを獲得しよう!",
              message:
                  "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
              yesAction: () => TLAds.showRewardedAd(
                context: context,
                rewardAction: () async {
                  TLAds.extendLimitOfPassReward(howManyDays: 3);
                  await const TLSingleOptionDialog(
                    title: "PASSが延長されました!",
                    message: "3日分のPASSを獲得しました",
                  ).show(context: context);
                },
              ),
            ).show(context: context);
          }
        },
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: isCurrentIcon ? 0 : 3,
          color: tlThemeData.panelColor,
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
                            ? tlThemeData.checkmarkColor
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
                              ? tlThemeData.checkmarkColor
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
