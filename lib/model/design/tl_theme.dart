import 'package:flutter/material.dart';

class TLTheme extends InheritedWidget {
  final TLThemeData data;

  const TLTheme({super.key, required this.data, required super.child});

  static TLThemeData of(BuildContext context) {
    final TLTheme? customTheme =
        context.dependOnInheritedWidgetOfExactType<TLTheme>();
    return customTheme!.data;
  }

  @override
  bool updateShouldNotify(TLTheme oldWidget) {
    return data != oldWidget.data;
  }
}

class TLThemeData {
  final String themeName;
  final String themeTitleInSettings;
  // 設定ページ系
  final Color titleColorOfSettingPage;
  final Color settingPanelColor;
  final Color notifyLogInBonusBadgeColor;
  // tips系
  final Color tipsCardBorderColor;
  final Color panelBorderColor;
  // nice apps系
  final Color tlDoubleCardColor;
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

  TLThemeData({
    required this.themeName,
    required this.themeTitleInSettings,
    // 設定ページ系
    required this.titleColorOfSettingPage,
    required this.settingPanelColor,
    required this.notifyLogInBonusBadgeColor,
    // tips系
    required this.tipsCardBorderColor,
    required this.panelBorderColor,
    // nice apps系
    required this.tlDoubleCardColor,
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
