import 'package:flutter/material.dart';

class NiceApp {
  static const int currentNiceAppIndex = 0;

  // アプリ名とアイコンのパス
  final String appName;
  final String catchCopy;
  final String appIconPath;
  // url
  final String appStoreUrl;
  final String playStoreUrl;
  final String roughUsageUrl;
  NiceApp({
    // アプリ名とアイコンのパス
    required this.appName,
    required this.catchCopy,
    required this.appIconPath,
    // url
    required this.appStoreUrl,
    required this.playStoreUrl,
    required this.roughUsageUrl,
  });
}

class NiceAppDesignSet {
  final Color panelThemeColor;
  final Color elevatedButtonColor;
  final Color pressedElevatedButtonColor;
  NiceAppDesignSet(
      {required this.panelThemeColor,
      required this.elevatedButtonColor,
      required this.pressedElevatedButtonColor});
}

List<NiceApp> niceApps = [
  NiceApp(
    // アプリ名とアイコンのパス
    appName: "Today List",
    catchCopy: "今日やることを明確にする",
    appIconPath: "other_app_icons/today_list.png",
    // url
    appStoreUrl: "",
    playStoreUrl: "",
    roughUsageUrl: "",
  ),
  NiceApp(
    // アプリ名とアイコンのパス
    appName: "Action Chain",
    catchCopy: "一連の作業をミスなくこなす",
    appIconPath: "other_app_icons/action_chain.png",
    // url
    appStoreUrl: "",
    playStoreUrl: "",
    roughUsageUrl: "",
  ),
  // NiceApp(
  //   // アプリ名とアイコンのパス
  //   appName: "APM",
  //   catchCopy: "最速で成功するための分析",
  //   appIconPath: "nice_app_icons/apm.png",
  //   // デザイン
  //   appDesignSet: NiceAppDesignSet(
  //     panelThemeColor: const Color.fromRGBO(137, 170, 236, 1),
  //     elevatedButtonColor: const Color.fromRGBO(128, 179, 255, 1),
  //     pressedElevatedButtonColor: const Color.fromRGBO(189, 215, 255, 1),
  //   ),
  //   // url
  //   appStoreUrl: "https://apps.apple.com/us/app/apm/id1614418932",
  //   playStoreUrl:
  //       "https://play.google.com/store/apps/details?id=com.akitora0703.apm",
  //   roughUsageUrl: "https://akinoki.blogspot.com/2022/03/apm-rough-usage.html",
  // ),
];
