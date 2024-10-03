import 'package:flutter/material.dart';

class TodayListTheme {
  final String themeTitle;
  // 設定ページ系
  final Color titleColorOfSettingPage;
  final Color settingPanelColor;
  final Color notifyLogInBonusBadgeColor;
  // tips系
  final Color tipsCardBorderColor;
  final Color panelBorderColor;
  // nice apps系
  final Color niceAppsCardColor;
  final Color niceAppsElevatedButtonColor;
  final Color niceAppsPressedElevatedButtonColor;
  // 基本色
  final Gradient gradientOfNavBar;
  final Color backgroundColor;
  final Color panelColor;
  final MaterialColor accentColor;
  final Color checkmarkColor;
  // アラート
  final Color alertColor;
  // category list系
  final Color bigCategoryChipColor;
  // todo、カテゴリー追加系
  final Color toggleButtonsBackgroundColor;
  final Color toggleButtonsBackgroundSplashColor;
  // my page
  final Color backupButtonBorderColor;
  final Color backupButtonTextColor;
  // reward
  final Color rewardButtonTitleColor;

  TodayListTheme({
    required this.themeTitle,
    // 設定ページ系
    required this.titleColorOfSettingPage,
    required this.settingPanelColor,
    required this.notifyLogInBonusBadgeColor,
    // tips系
    required this.tipsCardBorderColor,
    required this.panelBorderColor,
    // nice apps系
    required this.niceAppsCardColor,
    required this.niceAppsElevatedButtonColor,
    required this.niceAppsPressedElevatedButtonColor,
    // 基本色
    required this.accentColor,
    required this.gradientOfNavBar,
    required this.backgroundColor,
    required this.checkmarkColor,
    required this.panelColor,
    // アラート
    required this.alertColor,
    // category list系
    required this.bigCategoryChipColor,
    // todo、カテゴリー追加系
    required this.toggleButtonsBackgroundColor,
    required this.toggleButtonsBackgroundSplashColor,
    // my page
    required this.backupButtonBorderColor,
    required this.backupButtonTextColor,
    // reward
    required this.rewardButtonTitleColor,
    //
  });
}

final Map<String, TodayListTheme> theme = {
  "Sun Orange": TodayListTheme(
    themeTitle: "Sun\nOrange",
    // 設定ページ系
    titleColorOfSettingPage: const Color.fromRGBO(170, 119, 80, 1),
    settingPanelColor: const Color.fromRGBO(255, 243, 184, 1),
    notifyLogInBonusBadgeColor: const Color.fromRGBO(255, 154, 70, 1),
    // tips系
    tipsCardBorderColor: const Color.fromRGBO(255, 186, 107, 1),
    // nice apps系
    niceAppsCardColor: const Color.fromRGBO(255, 192, 97, 1),
    niceAppsElevatedButtonColor: const Color.fromRGBO(255, 192, 97, 1),
    niceAppsPressedElevatedButtonColor: const Color.fromRGBO(255, 222, 173, 1),
    // 基本色
    accentColor: Colors.orange,
    gradientOfNavBar: const LinearGradient(colors: [
      Color.fromRGBO(255, 163, 163, 1),
      Color.fromRGBO(255, 230, 87, 1),
    ]),
    backgroundColor: const Color.fromRGBO(255, 229, 214, 1),
    checkmarkColor: const Color.fromRGBO(255, 190, 86, 1),
    panelColor: const Color.fromRGBO(235, 255, 179, 1),
    panelBorderColor: const Color.fromRGBO(255, 192, 97, 1),
    // アラート
    alertColor: const Color.fromRGBO(255, 251, 224, 1),
    // category list系
    bigCategoryChipColor: const Color.fromRGBO(255, 190, 86, 1),
    // todo、カテゴリー追加系
    toggleButtonsBackgroundColor: const Color.fromRGBO(176, 255, 107, 0.3),
    toggleButtonsBackgroundSplashColor:
        const Color.fromRGBO(176, 255, 107, 0.5),
    // my page
    backupButtonBorderColor: const Color.fromRGBO(255, 170, 117, 1),
    backupButtonTextColor: const Color.fromRGBO(255, 189, 102, 1),
    // reward
    rewardButtonTitleColor: const Color.fromRGBO(255, 190, 86, 1),
    // settings
  ),
  "Lime Green": TodayListTheme(
    themeTitle: "Lime\nGreen",
    // 設定ページ系
    settingPanelColor: const Color.fromRGBO(223, 168, 139, 1),
    titleColorOfSettingPage: const Color.fromRGBO(130, 81, 43, 1),
    notifyLogInBonusBadgeColor: const Color.fromRGBO(255, 243, 10, 1),
    // tips
    tipsCardBorderColor: const Color.fromRGBO(166, 238, 114, 1),
    // nice apps系
    niceAppsCardColor: const Color.fromRGBO(225, 163, 102, 1),
    niceAppsElevatedButtonColor: const Color.fromRGBO(138, 231, 101, 1),
    niceAppsPressedElevatedButtonColor: const Color.fromRGBO(195, 243, 176, 1),
    // 基本色
    gradientOfNavBar: const LinearGradient(colors: [
      Color.fromRGBO(73, 194, 70, 1),
      Color.fromRGBO(143, 250, 56, 1),
    ]),
    backgroundColor: const Color.fromRGBO(239, 255, 214, 1),
    panelColor: const Color.fromRGBO(255, 253, 184, 1),
    accentColor: Colors.lightGreen,
    checkmarkColor: const Color.fromRGBO(123, 212, 28, 1),
    panelBorderColor: const Color.fromRGBO(225, 163, 102, 1),
    // アラート
    alertColor: const Color.fromRGBO(255, 255, 209, 1),
    // category list系
    bigCategoryChipColor: const Color.fromRGBO(136, 213, 11, 1),
    // todo、カテゴリー追加系
    toggleButtonsBackgroundColor: const Color.fromRGBO(255, 255, 173, 0.5),
    toggleButtonsBackgroundSplashColor:
        const Color.fromRGBO(255, 255, 173, 0.5),
    // my page
    backupButtonBorderColor: const Color.fromRGBO(225, 163, 102, 1),
    backupButtonTextColor: Colors.lightGreen.withOpacity(0.8),
    // reward
    rewardButtonTitleColor: const Color.fromRGBO(123, 205, 60, 1),
  ),
  "Marine Blue": TodayListTheme(
    themeTitle: "Marine\nBlue",
    // 設定ページ系
    titleColorOfSettingPage: Colors.cyan,
    settingPanelColor: const Color.fromRGBO(219, 248, 255, 1),
    notifyLogInBonusBadgeColor: const Color.fromRGBO(122, 167, 245, 1),
    // tips系
    tipsCardBorderColor: const Color.fromRGBO(163, 218, 255, 1),
    // nice apps系
    niceAppsCardColor: const Color.fromRGBO(129, 221, 234, 1),
    niceAppsElevatedButtonColor: const Color.fromRGBO(89, 211, 227, 1),
    niceAppsPressedElevatedButtonColor: const Color.fromRGBO(163, 231, 239, 1),
    // 基本色
    accentColor: Colors.cyan,
    gradientOfNavBar: const LinearGradient(colors: [
      Color.fromRGBO(131, 169, 252, 1),
      Color.fromRGBO(144, 242, 249, 1),
    ]),
    backgroundColor: const Color.fromRGBO(241, 251, 253, 1),
    checkmarkColor: const Color.fromRGBO(66, 183, 255, 1),
    panelColor: const Color.fromRGBO(214, 252, 255, 1),
    panelBorderColor: const Color.fromRGBO(163, 218, 255, 1),
    // アラート
    alertColor: const Color.fromRGBO(240, 248, 255, 1),
    // category list系
    bigCategoryChipColor: const Color.fromRGBO(133, 214, 255, 1),
    // todo、カテゴリー追加系
    toggleButtonsBackgroundColor: Colors.lightBlue.withOpacity(0.1),
    toggleButtonsBackgroundSplashColor: Colors.lightBlue.withOpacity(0.1),
    // my page
    backupButtonBorderColor: const Color.fromRGBO(113, 199, 249, 1),
    backupButtonTextColor: const Color.fromRGBO(90, 209, 242, 1),
    // reward
    rewardButtonTitleColor: Colors.cyan,
  ),
};
