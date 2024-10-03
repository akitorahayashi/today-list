import 'package:flutter/material.dart';
import '../../../../constants/theme.dart';
import '../../../../constants/global_keys.dart';
import '../../../../alerts/yes_no_alert.dart';
import '../../../../alerts/simple_alert.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/externals/tl_ads.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RightSideThemeSelectButton extends StatefulWidget {
  final String themeName;
  const RightSideThemeSelectButton({
    super.key,
    required this.themeName,
  });

  @override
  State<RightSideThemeSelectButton> createState() =>
      _RightSideThemeSelectButtonState();
}

class _RightSideThemeSelectButtonState
    extends State<RightSideThemeSelectButton> {
  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () async {
        if (TLAds.isPassActive) {
          settingData.confirmToChangeTheme(
            context: context,
            themeName: widget.themeName,
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
              gradient: theme[widget.themeName]!.gradientOfNavBar,
              borderRadius: BorderRadius.circular(10)),
          // ガラス
          child: GlassContainer(
            // カードを中央に配置
            child: Align(
              alignment: Alignment.center,
              // todoのカードを表示
              child: Card(
                elevation: 5,
                color: theme[widget.themeName]!.panelColor,
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
                            color: theme[widget.themeName]!.checkmarkColor,
                          ),
                        ),
                        Text(
                          theme[widget.themeName]!.themeTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: theme[widget.themeName]!.checkmarkColor,
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
