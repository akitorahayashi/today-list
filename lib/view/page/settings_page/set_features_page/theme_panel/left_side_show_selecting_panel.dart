import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftSideShowingSelectingPanel extends StatelessWidget {
  const LeftSideShowingSelectingPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth / 2 - 20,
      height: 320,
      // グラデーションと丸角
      decoration: BoxDecoration(
          gradient: tlThemeConfig.gradientOfNavBar,
          borderRadius: BorderRadius.circular(10)),
      // ガラス
      child: Align(
        alignment: Alignment.center,
        // toDoカードを表示
        child: Card(
          elevation: 5,
          color: tlThemeConfig.canTapCardColor,
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
                      color: tlThemeConfig.checkmarkColor,
                    ),
                  ),
                  Text(
                    tlThemeConfig.themeTitleInSettings,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tlThemeConfig.checkmarkColor,
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
    );
  }
}
