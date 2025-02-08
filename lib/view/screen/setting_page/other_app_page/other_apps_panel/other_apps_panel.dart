import 'package:flutter/material.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import '../../../../../model/design/tl_theme/tl_theme.dart';
import 'other_app_card/other_app_card.dart';
import 'other_apps_model.dart';

class OtherAppsPanel extends StatelessWidget {
  const OtherAppsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return TLDoubleCard(
      child: Column(
        children: [
          // 文字
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Other Apps",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 26,
                        color: tlThemeData.tlDoubleCardColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Icon(
                    Icons.thumb_up,
                    color: tlThemeData.tlDoubleCardColor,
                  ),
                )
              ],
            ),
          ),
          // other appsを表示
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: [
                NiceAppCard(
                    isCurrentApp: true,
                    otherAppOfThisCard: otherApps[OtherApp.currentAppIndex]),
                for (int index = 0; index < otherApps.length; index++)
                  if (index != OtherApp.currentAppIndex)
                    NiceAppCard(
                        isCurrentApp: false,
                        otherAppOfThisCard: otherApps[index]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
