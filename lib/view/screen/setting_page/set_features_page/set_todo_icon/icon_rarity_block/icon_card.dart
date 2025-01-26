import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_icon_data.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/view_model/design/tl_icon_data_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import '../../../../../component/dialog/common/tl_single_option_dialog.dart';
import '../../../../../component/dialog/common/tl_yes_no_dialog.dart';
import '../../../../../../service/tl_ads.dart';
import '../../../../../../model/design/tl_theme.dart';
import '../../../../../../main.dart';

class IconCard extends ConsumerStatefulWidget {
  final bool isEarned;
  final TLIconCategory tlIconCategory;
  final TLIconRarity tlIconRarity;
  final TLIconName tlIconName;
  const IconCard({
    super.key,
    required this.isEarned,
    required this.tlIconCategory,
    required this.tlIconRarity,
    required this.tlIconName,
  });

  @override
  ConsumerState<IconCard> createState() => _IconCardState();
}

class _IconCardState extends ConsumerState<IconCard> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final TLIconData tlIconData = ref.watch(tlIconDataProvider);
    final TLIconDataNotifier tlIconDataNotifier =
        ref.read(tlIconDataProvider.notifier);
    final bool isCurrentIcon = widget.tlIconCategory == tlIconData.category &&
        widget.tlIconRarity == tlIconData.rarity &&
        widget.tlIconName == tlIconData.name;
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () async {
          if (TLAdsService.isPassActive || kDebugMode) {
            if (!isCurrentIcon) {
              await TLYesNoDialog(
                  title: "アイコンの変更",
                  message: "チェックマークのアイコンを\n変更しますか?",
                  yesAction: () async {
                    Navigator.pop(context);
                    tlIconDataNotifier.updateSelectedIcon(TLIconData(
                        category: widget.tlIconCategory,
                        rarity: widget.tlIconRarity,
                        name: widget.tlIconName));
                    TLVibrationService.vibrate();
                    const TLSingleOptionDialog(title: "変更が完了しました!")
                        .show(context: context);
                    TLVibrationService.vibrate();
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
              yesAction: () => TLAdsService.showRewardedAd(
                context: context,
                rewardAction: () async {
                  TLAdsService.extendLimitOfPassReward(howManyDays: 3);
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
                  padding: const EdgeInsets.only(top: 3, bottom: 4),
                  child: Icon(
                    !widget.isEarned
                        ? Icons.help_outline
                        : isCurrentIcon
                            ? tlIconResource[widget.tlIconCategory]![
                                    widget.tlIconRarity]![widget.tlIconName]!
                                .checkedIcon
                            : tlIconResource[widget.tlIconCategory]![
                                    widget.tlIconRarity]![widget.tlIconName]!
                                .notCheckedIcon,
                    color: !widget.isEarned
                        ? Colors.black26
                        : isCurrentIcon
                            ? tlThemeData.checkmarkColor
                            : Colors.black45,
                    size: 20,
                  ),
                ),
                Text(
                  !widget.isEarned ? "???" : widget.tlIconName.rawValue,
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
