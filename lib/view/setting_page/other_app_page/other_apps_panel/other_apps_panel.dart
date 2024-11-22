import 'package:flutter/material.dart';
import '../../../../model/tl_theme.dart';
import './other_app_card/other_app_card.dart';
import './other_apps_model.dart';

class NiceAppsPanel extends StatelessWidget {
  const NiceAppsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Card(
      color: tlThemeData.otherAppsCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      "Nice Apps",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                          color: tlThemeData.otherAppsCardColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Icon(
                      Icons.thumb_up,
                      color: tlThemeData.otherAppsCardColor,
                    ),
                  )
                ],
              ),
            ),
            // nice appsを表示
            Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Column(
                children: [
                  NiceAppCard(
                      isCurrentApp: true,
                      niceAppOfThisCard: niceApps[OtherApp.currentAppIndex]),
                  for (int index = 0; index < niceApps.length; index++)
                    if (index != OtherApp.currentAppIndex)
                      NiceAppCard(
                          isCurrentApp: false,
                          niceAppOfThisCard: niceApps[index]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
