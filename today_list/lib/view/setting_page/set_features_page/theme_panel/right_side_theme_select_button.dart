import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../components/dialog/common/single_option_dialog.dart';
import '../../../../components/dialog/common/yes_no_dialog.dart';
import '../../../../model/external/tl_ads.dart';
import 'change_theme_dialog.dart';

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
    final TLThemeData _corrThemeData = tlThemeDataList[widget.corrIndex];
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (TLAds.isPassActive || kDebugMode) {
          showDialog(
              context: context,
              builder: ((context) => ChangeThemeDialog(
                    corrIndex: widget.corrIndex,
                    corrThemeData: _corrThemeData,
                  )));
        } else {
          await showDialog(
              context: context,
              builder: ((context) {
                return YesNoDialog(
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
                            return SingleOptionDialog(
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
              gradient: _corrThemeData.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: GlassContainer(
            // カードを中央に配置
            child: Align(
              alignment: Alignment.center,
              // todoのカードを表示
              child: Card(
                elevation: 5,
                color: _corrThemeData.panelColor,
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
                            color: _corrThemeData.checkmarkColor,
                          ),
                        ),
                        Text(
                          _corrThemeData.themeTitleInSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: _corrThemeData.checkmarkColor,
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
