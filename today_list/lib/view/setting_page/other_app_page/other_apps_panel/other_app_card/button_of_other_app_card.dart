import 'package:flutter/material.dart';
import '../../../../../constants/theme.dart';
import '../../../../../model/user/setting_data.dart';
import '../../../../../launch_my_url.dart';
import '../other_apps_model.dart';
import 'dart:io';

class ButtonInNiceAppCard extends StatelessWidget {
  final bool isCurrentApp;
  final bool isStoreUrl;
  final NiceApp niceAppInThisCard;
  const ButtonInNiceAppCard({
    super.key,
    required this.isCurrentApp,
    required this.isStoreUrl,
    required this.niceAppInThisCard,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth / 2 - 50,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (isStoreUrl) {
            if (isCurrentApp) {
              launchMyUrl(
                  context: context,
                  url: Platform.isIOS
                      ? niceAppInThisCard.appStoreUrl
                      : niceAppInThisCard.playStoreUrl,
                  shouldUseExternalApplication: isStoreUrl);
            } else {
              launchMyUrl(
                  context: context,
                  url: Platform.isIOS
                      ? niceAppInThisCard.appStoreUrl
                      : niceAppInThisCard.playStoreUrl,
                  shouldUseExternalApplication: isStoreUrl);
            }
          } else {
            // detail
            launchMyUrl(
                context: context,
                url: niceAppInThisCard.roughUsageUrl,
                shouldUseExternalApplication: isStoreUrl);
          }
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
              theme[settingData.selectedTheme]!
                  .niceAppsPressedElevatedButtonColor),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return const Color.fromRGBO(220, 220, 220, 1);
              }
              return theme[settingData.selectedTheme]!
                  .niceAppsElevatedButtonColor;
            },
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
              return 2;
            },
          ),
        ),
        child: Text(
          isStoreUrl ? (isCurrentApp ? "Review" : "Install") : "Detail",
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 20,
              letterSpacing: 0.5),
        ),
      ),
    );
  }
}
