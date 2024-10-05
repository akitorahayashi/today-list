import 'package:flutter/material.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../constants/theme.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftSideShowingSelectingPanel extends StatelessWidget {
  final double deviceWidth;
  const LeftSideShowingSelectingPanel({
    super.key,
    required this.deviceWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth / 2 - 20,
      height: 320,
      // グラデーションと丸角
      decoration: BoxDecoration(
          gradient: theme[SettingData.shared.selectedTheme]!.gradientOfNavBar,
          borderRadius: BorderRadius.circular(10)),
      // ガラス
      child: GlassContainer(
        // カードを中央に配置
        child: Align(
          alignment: Alignment.center,
          // toDoカードを表示
          child: Card(
            elevation: 5,
            color: theme[SettingData.shared.selectedTheme]!.panelColor,
            child: SizedBox(
              width: deviceWidth / 2 - 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        FontAwesomeIcons.solidSquareCheck,
                        color: theme[SettingData.shared.selectedTheme]!
                            .checkmarkColor,
                      ),
                    ),
                    Text(
                      theme[SettingData.shared.selectedTheme]!.themeTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: theme[SettingData.shared.selectedTheme]!
                              .checkmarkColor,
                          fontSize: 17,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
