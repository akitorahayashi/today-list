import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import 'package:today_list/view/component/dialog/change_theme_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_ads.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightSideThemeSelectButton extends StatefulWidget {
  final TLThemeType corrThemeType;
  const RightSideThemeSelectButton({
    super.key,
    required this.corrThemeType,
  });

  @override
  State<RightSideThemeSelectButton> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends State<RightSideThemeSelectButton> {
  @override
  Widget build(BuildContext context) {
    final TLThemeType corrThemeType = widget.corrThemeType;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (TLAdsService.isPassActive || kDebugMode) {
          await ChangeThemeDialog(
            corrThemeType: corrThemeType,
          ).show(context: context);
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
      child: Container(
          width: deviceWidth / 2 - 50,
          height: 150,
          decoration: BoxDecoration(
              gradient: corrThemeType.config.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: GlassContainer(
            // カードを中央に配置
            child: Align(
              alignment: Alignment.center,
              // todoのカードを表示
              child: Card(
                elevation: 5,
                color: corrThemeType.config.canTapCardColor,
                child: SizedBox(
                  width: deviceWidth / 2 - 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FaIcon(
                            FontAwesomeIcons.square,
                            color: corrThemeType.config.checkmarkColor,
                          ),
                        ),
                        Text(
                          corrThemeType.config.themeTitleInSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: corrThemeType.config.checkmarkColor,
                              fontSize: 12,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
