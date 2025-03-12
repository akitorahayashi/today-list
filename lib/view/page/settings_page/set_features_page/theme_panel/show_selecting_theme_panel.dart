import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowSelectingThemePanel extends StatelessWidget {
  const ShowSelectingThemePanel({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      // グラデーションと丸角
      decoration: BoxDecoration(
        gradient: tlThemeConfig.gradientOfNavBar,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.center,
        // toDoカードを表示
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Card(
            elevation: 5,
            color: tlThemeConfig.canTapCardColor,
            child: SizedBox(
              width: 200, // 固定幅で中央に表示
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tlThemeConfig.themeTitleInSettings,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: tlThemeConfig.accentColor,
                        fontSize: 24, // フォントサイズを大きく
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      FontAwesomeIcons.solidSquareCheck,
                      color: tlThemeConfig.accentColor,
                      size: 32, // アイコンサイズを大きく
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
