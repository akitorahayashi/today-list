import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

part 'generate/tl_theme_type.g.dart';

// $ dart run build_runner build

@JsonEnum(alwaysCreate: true)
enum TLThemeType {
  @JsonValue("sunOrange")
  sunOrange(
    TLThemeConfig(
      themeName: "Sun Orange",
      themeTitleInSettings: "Sun\nOrange",
      titleColorOfSettingPage: Color.fromRGBO(170, 119, 80, 1),
      settingPanelColor: Color.fromRGBO(255, 243, 184, 1),
      notifyLogInBonusBadgeColor: Color.fromRGBO(255, 154, 70, 1),
      tipsCardBorderColor: Color.fromRGBO(255, 186, 107, 1),
      panelBorderColor: Color.fromRGBO(255, 192, 97, 1),
      tlDoubleCardColor: Color.fromRGBO(255, 192, 97, 1),
      niceAppsElevatedButtonColor: Color.fromRGBO(255, 192, 97, 1),
      niceAppsPressedElevatedButtonColor: Color.fromRGBO(255, 222, 173, 1),
      accentColor: Colors.orange,
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(255, 163, 163, 1),
        Color.fromRGBO(255, 230, 87, 1),
      ]),
      backgroundColor: Color.fromRGBO(255, 229, 214, 1),
      checkmarkColor: Color.fromRGBO(255, 190, 86, 1),
      panelColor: Color.fromRGBO(235, 255, 179, 1),
      alertColor: Color.fromRGBO(255, 251, 224, 1),
      bigCategoryChipColor: Color.fromRGBO(255, 190, 86, 1),
      toggleButtonsBackgroundColor: Color.fromRGBO(176, 255, 107, 0.3),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(176, 255, 107, 0.5),
      backupButtonBorderColor: Color.fromRGBO(255, 170, 117, 1),
      backupButtonTextColor: Color.fromRGBO(255, 189, 102, 1),
      rewardButtonTitleColor: Color.fromRGBO(255, 190, 86, 1),
    ),
  ),

  @JsonValue("limeGreen")
  limeGreen(
    TLThemeConfig(
      themeName: "Lime Green",
      themeTitleInSettings: "Lime\nGreen",
      titleColorOfSettingPage: Color.fromRGBO(130, 81, 43, 1),
      settingPanelColor: Color.fromRGBO(223, 168, 139, 1),
      notifyLogInBonusBadgeColor: Color.fromRGBO(255, 243, 10, 1),
      tipsCardBorderColor: Color.fromRGBO(166, 238, 114, 1),
      panelBorderColor: Color.fromRGBO(225, 163, 102, 1),
      tlDoubleCardColor: Color.fromRGBO(225, 163, 102, 1),
      niceAppsElevatedButtonColor: Color.fromRGBO(138, 231, 101, 1),
      niceAppsPressedElevatedButtonColor: Color.fromRGBO(195, 243, 176, 1),
      accentColor: Colors.lightGreen,
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(73, 194, 70, 1),
        Color.fromRGBO(143, 250, 56, 1),
      ]),
      backgroundColor: Color.fromRGBO(239, 255, 214, 1),
      checkmarkColor: Color.fromRGBO(123, 212, 28, 1),
      panelColor: Color.fromRGBO(255, 253, 184, 1),
      alertColor: Color.fromRGBO(255, 255, 209, 1),
      bigCategoryChipColor: Color.fromRGBO(136, 213, 11, 1),
      toggleButtonsBackgroundColor: Color.fromRGBO(255, 255, 173, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(255, 255, 173, 0.5),
      backupButtonBorderColor: Color.fromRGBO(225, 163, 102, 1),
      backupButtonTextColor: Colors.lightGreen,
      rewardButtonTitleColor: Color.fromRGBO(123, 205, 60, 1),
    ),
  ),

  @JsonValue("marineBlue")
  marineBlue(
    TLThemeConfig(
      themeName: "Marine Blue",
      themeTitleInSettings: "Marine\nBlue",
      titleColorOfSettingPage: Colors.cyan,
      settingPanelColor: Color.fromRGBO(219, 248, 255, 1),
      notifyLogInBonusBadgeColor: Color.fromRGBO(122, 167, 245, 1),
      tipsCardBorderColor: Color.fromRGBO(163, 218, 255, 1),
      panelBorderColor: Color.fromRGBO(163, 218, 255, 1),
      tlDoubleCardColor: Color.fromRGBO(129, 221, 234, 1),
      niceAppsElevatedButtonColor: Color.fromRGBO(89, 211, 227, 1),
      niceAppsPressedElevatedButtonColor: Color.fromRGBO(163, 231, 239, 1),
      accentColor: Colors.cyan,
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(131, 169, 252, 1),
        Color.fromRGBO(144, 242, 249, 1),
      ]),
      backgroundColor: Color.fromRGBO(241, 251, 253, 1),
      checkmarkColor: Color.fromRGBO(66, 183, 255, 1),
      panelColor: Color.fromRGBO(214, 252, 255, 1),
      alertColor: Color.fromRGBO(240, 248, 255, 1),
      bigCategoryChipColor: Color.fromRGBO(133, 214, 255, 1),
      toggleButtonsBackgroundColor: Colors.lightBlue.withOpacity(0.1),
      toggleButtonsBackgroundSplashColor: Colors.lightBlue.withOpacity(0.1),
      backupButtonBorderColor: Color.fromRGBO(113, 199, 249, 1),
      backupButtonTextColor: Color.fromRGBO(90, 209, 242, 1),
      rewardButtonTitleColor: Colors.cyan,
    ),
  );

  final TLThemeConfig config;

  const TLThemeType(this.config);

  /// JSON から TLThemeType を取得
  static TLThemeType fromJson(String json) => _$TLThemeTypeEnumMap.entries
      .firstWhere(
        (e) => e.value == json,
        orElse: () => _$TLThemeTypeEnumMap.entries.firstWhere(
          (e) => e.key == TLThemeType.sunOrange, // デフォルトを指定
        ),
      )
      .key;

  String toJson() => _$TLThemeTypeEnumMap[this] ?? 'sunOrange';
}
