import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import '../other_apps_model.dart';

class ButtonInOtherAppCard extends StatelessWidget {
  final bool isCurrentApp;
  final bool isStoreUrl;
  final OtherApp niceAppInThisCard;
  const ButtonInOtherAppCard({
    super.key,
    required this.isCurrentApp,
    required this.isStoreUrl,
    required this.niceAppInThisCard,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return SizedBox(
      width: deviceWidth / 2 - 50,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (isStoreUrl) {
            if (isCurrentApp) {
              // launchMyUrl(
              //     context: context,
              //     url: Platform.isIOS
              //         ? niceAppInThisCard.appStoreUrl
              //         : niceAppInThisCard.playStoreUrl,
              //     shouldUseExternalApplication: isStoreUrl);
            } else {
              // launchMyUrl(
              //     context: context,
              //     url: Platform.isIOS
              //         ? niceAppInThisCard.appStoreUrl
              //         : niceAppInThisCard.playStoreUrl,
              //     shouldUseExternalApplication: isStoreUrl);
            }
          } else {
            // detail
            // launchMyUrl(
            //     context: context,
            //     url: niceAppInThisCard.roughUsageUrl,
            //     shouldUseExternalApplication: isStoreUrl);
          }
        },
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(
              tlThemeData.niceAppsPressedElevatedButtonColor),
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return const Color.fromRGBO(220, 220, 220, 1);
              }
              return tlThemeData.niceAppsElevatedButtonColor;
            },
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
          elevation: WidgetStateProperty.resolveWith<double>(
            (Set<WidgetState> states) {
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
