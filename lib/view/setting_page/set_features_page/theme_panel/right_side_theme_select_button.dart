import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../../../model/tl_theme.dart';
import '../../../../component/dialog/common/tl_single_option_dialog.dart';
import '../../../../component/dialog/common/tl_yes_no_dialog.dart';
import '../../../../model/external/tl_ads.dart';
import '../../../../component/dialog/change_theme_dialog.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightSideThemeSelectButton extends StatefulWidget {
  final int corrIndex;
  const RightSideThemeSelectButton({
    super.key,
    required this.corrIndex,
  });

  @override
  State<RightSideThemeSelectButton> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends State<RightSideThemeSelectButton> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData corrThemeData = tlThemeDataList[widget.corrIndex];
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (TLAds.isPassActive || kDebugMode) {
          showDialog(
              context: context,
              builder: ((context) => ChangeThemeDialog(
                    corrIndex: widget.corrIndex,
                    corrThemeData: corrThemeData,
                  )));
        } else {
          await showDialog(
              context: context,
              builder: ((context) {
                return TLYesNoDialog(
                  title: "PASSを獲得しよう!",
                  message:
                      "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンやカラーテーマを変更することができます!\n\n・1回の動画広告で3日分獲得できます",
                  yesAction: () => TLAds.showRewardedAd(
                    context: context,
                    rewardAction: () async {
                      TLAds.extendLimitOfPassReward(howManyDays: 3);
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return const TLSingleOptionDialog(
                              title: "PASSが延長されました!",
                              message: "3日分のPASSを獲得しました",
                            );
                          });
                    },
                  ),
                );
              }));
        }
      },
      child: Container(
          width: deviceWidth / 2 - 50,
          height: 150,
          decoration: BoxDecoration(
              gradient: corrThemeData.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: GlassContainer(
            // カードを中央に配置
            child: Align(
              alignment: Alignment.center,
              // todoのカードを表示
              child: Card(
                elevation: 5,
                color: corrThemeData.panelColor,
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
                            color: corrThemeData.checkmarkColor,
                          ),
                        ),
                        Text(
                          corrThemeData.themeTitleInSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: corrThemeData.checkmarkColor,
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
