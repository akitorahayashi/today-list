import 'package:flutter/material.dart';
import '../../../../../model/design/tl_theme/tl_theme.dart';

import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LeftSideShowingSelectingPanel extends StatelessWidget {
  const LeftSideShowingSelectingPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: deviceWidth / 2 - 20,
      height: 320,
      // グラデーションと丸角
      decoration: BoxDecoration(
          gradient: tlThemeData.gradientOfNavBar,
          borderRadius: BorderRadius.circular(10)),
      // ガラス
      child: GlassContainer(
        // カードを中央に配置
        child: Align(
          alignment: Alignment.center,
          // toDoカードを表示
          child: Card(
            elevation: 5,
            color: tlThemeData.panelColor,
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
                        color: tlThemeData.checkmarkColor,
                      ),
                    ),
                    Text(
                      tlThemeData.themeTitleInSettings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: tlThemeData.checkmarkColor,
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
