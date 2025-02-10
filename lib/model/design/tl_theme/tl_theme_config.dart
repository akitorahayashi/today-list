import 'package:flutter/material.dart';

/// テーマの構成情報を管理するクラス
class TLThemeConfig {
  // Theme Name
  final String themeName;
  final String themeTitleInSettings;

  // Settings Page
  final Color titleColorOfSettingPage;
  final Color settingPanelColor;

  // other apps
  final Color otherAppsElevatedButtonColor;
  final Color otherAppsPressedElevatedButtonColor;

  // Home Page
  final Color backgroundColor;

  // Navigation Bar
  final Gradient gradientOfNavBar;

  // Basics
  final MaterialColor accentColor;
  final Color canTapCardColor;
  final Color whiteBasedCardColor;
  final Color tlDoubleCardBorderColor;
  final Color checkmarkColor;

  // Alert
  final Color alertBackgroundColor;

  // Category List
  final Color bigCategoryChipColor;

  // Edit Page
  final Color toggleButtonsBackgroundColor;
  final Color toggleButtonsBackgroundSplashColor;

  const TLThemeConfig({
    // Theme Name
    required this.themeName,
    required this.themeTitleInSettings,

    // Settings Page
    required this.titleColorOfSettingPage,
    required this.settingPanelColor,

    // Home Page
    required this.backgroundColor,

    // Navigation Bar
    required this.gradientOfNavBar,

    // Other Apps
    required this.otherAppsElevatedButtonColor,
    required this.otherAppsPressedElevatedButtonColor,

    // Basics
    required this.accentColor,
    required this.canTapCardColor,
    required this.whiteBasedCardColor,
    required this.tlDoubleCardBorderColor,
    required this.checkmarkColor,

    // Alert
    required this.alertBackgroundColor,

    // Category List
    required this.bigCategoryChipColor,

    // Edit Page
    required this.toggleButtonsBackgroundColor,
    required this.toggleButtonsBackgroundSplashColor,
  });
}
