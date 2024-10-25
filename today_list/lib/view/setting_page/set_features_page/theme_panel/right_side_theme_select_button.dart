import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../../../model/tl_theme.dart';
import '../../../../constants/global_keys.dart';
import '../../../../alerts/yes_no_alert.dart';
import '../../../../alerts/simple_alert.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/external/tl_ads.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightSideThemeSelectButton extends StatefulWidget {
  final int IndexOfthemeData;
  const RightSideThemeSelectButton({
    super.key,
    required this.IndexOfthemeData,
  });

  @override
  State<RightSideThemeSelectButton> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends State<RightSideThemeSelectButton> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData _themeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (TLAds.isPassActive || kDebugMode) {
          SettingData.shared.confirmToChangeTheme(
            context: context,
            selectedThemeIndex: widget.IndexOfthemeData,
          );
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
                setAppearancePageKey.currentState?.setState(() {});
                simpleAlert(
                    context: context,
                    title: "PASSが延長されました!",
                    message: "3日分のPASSを獲得しました",
                    buttonText: "OK");
              },
            ),
          );
        }
      },
      child: Container(
          width: deviceWidth / 2 - 50,
          height: 150,
          decoration: BoxDecoration(
              gradient:
                  tlThemeDataList[widget.IndexOfthemeData]!.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: GlassContainer(
            // カードを中央に配置
            child: Align(
              alignment: Alignment.center,
              // todoのカードを表示
              child: Card(
                elevation: 5,
                color: tlThemeDataList[widget.IndexOfthemeData]!.panelColor,
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
                            color: tlThemeDataList[widget.IndexOfthemeData]!
                                .checkmarkColor,
                          ),
                        ),
                        Text(
                          tlThemeDataList[widget.IndexOfthemeData]!
                              .themeTitleInSettings,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: tlThemeDataList[widget.IndexOfthemeData]!
                                  .checkmarkColor,
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
