import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

part 'generate/tl_theme_type.g.dart';

// $ dart run build_runner build

@JsonEnum(alwaysCreate: true)
enum TLThemeType {
  @JsonValue("sunOrange")
  sunOrange(
    // config:
    TLThemeConfig(
      // Theme Name
      themeName: "Sun Orange",
      themeTitleInSettings: "Sun\nOrange",

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(170, 119, 80, 1),
      settingPanelColor: Color.fromRGBO(255, 243, 184, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(255, 229, 214, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(255, 163, 163, 1),
        Color.fromRGBO(255, 230, 87, 1),
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(255, 192, 97, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 222, 173, 1),

      // Basics
      accentColor: Colors.orange,
      canTapCardColor: Color.fromRGBO(235, 255, 179, 1),
      whiteBasedCardColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(255, 192, 97, 1),
      checkmarkColor: Color.fromRGBO(255, 190, 86, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(255, 251, 224, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(255, 190, 86, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(176, 255, 107, 0.3),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(176, 255, 107, 0.5),
    ),
  ),
  // darkConfig: TLThemeConfig(
  //   themeName: "Sun Orange (Dark)",
  //   themeTitleInSettings: "Sun\nOrange",
  //   titleColorOfSettingPage: Color.fromRGBO(0, 0, 0, 1),
  //   settingPanelColor: Color.fromRGBO(0, 0, 0, 1),
  //   backgroundColor: Color.fromRGBO(0, 0, 0, 1),
  //   gradientOfNavBar: LinearGradient(colors: [
  //     Color.fromRGBO(0, 0, 0, 1),
  //     Color.fromRGBO(0, 0, 0, 1),
  //   ]),
  //   otherAppsElevatedButtonColor: Color.fromRGBO(0, 0, 0, 1),
  //   otherAppsPressedElevatedButtonColor: Color.fromRGBO(0, 0, 0, 1),
  //   accentColor: Colors.deepOrange,
  //   canTapCardColor: Color.fromRGBO(0, 0, 0, 1),
  //   tlDoubleCardBorderColor: Color.fromRGBO(0, 0, 0, 1),
  //   checkmarkColor: Color.fromRGBO(0, 0, 0, 1),
  //   alertBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
  //   bigCategoryChipColor: Color.fromRGBO(0, 0, 0, 1),
  //   toggleButtonsBackgroundColor: Color.fromRGBO(0, 0, 0, 1),
  //   toggleButtonsBackgroundSplashColor: Color.fromRGBO(0, 0, 0, 1),
  // ),

  @JsonValue("limeGreen")
  limeGreen(
    TLThemeConfig(
      // Theme Name
      themeName: "Lime Green",
      themeTitleInSettings: "Lime\nGreen",

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(130, 81, 43, 1),
      settingPanelColor: Color.fromRGBO(223, 168, 139, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(239, 255, 214, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(73, 194, 70, 1),
        Color.fromRGBO(143, 250, 56, 1),
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(138, 231, 101, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(195, 243, 176, 1),

      // Basics
      accentColor: Colors.lightGreen,
      canTapCardColor: Color.fromRGBO(255, 253, 184, 1),
      whiteBasedCardColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(225, 163, 102, 1),
      checkmarkColor: Color.fromRGBO(123, 212, 28, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(255, 255, 209, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(136, 213, 11, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(255, 255, 173, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(255, 255, 173, 0.5),
    ),
  ),

  @JsonValue("marineBlue")
  marineBlue(
    TLThemeConfig(
      // Theme Name
      themeName: "Marine Blue",
      themeTitleInSettings: "Marine\nBlue",

      // Settings Page
      titleColorOfSettingPage: Colors.cyan,
      settingPanelColor: Color.fromRGBO(219, 248, 255, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(241, 251, 253, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(131, 169, 252, 1),
        Color.fromRGBO(144, 242, 249, 1),
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(89, 211, 227, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(163, 231, 239, 1),

      // Basics
      accentColor: Colors.cyan,
      canTapCardColor: Color.fromRGBO(214, 252, 255, 1),
      whiteBasedCardColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(129, 221, 234, 1),
      checkmarkColor: Color.fromRGBO(66, 183, 255, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(240, 248, 255, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(133, 214, 255, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Colors.lightBlue,
      toggleButtonsBackgroundSplashColor: Colors.lightBlue,
    ),
  );

  final TLThemeConfig config;
  // final TLThemeConfig darkConfig;

  // const TLThemeType({required this.config, required this.darkConfig});
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

// TLThemeConfig(
//     // Theme Name
//     themeName: "",
//     themeTitleInSettings: "",

//     // Settings Page
//     titleColorOfSettingPage: ,
//     settingPanelColor: ,

//     // Home Page
//     backgroundColor: ,

//     // Navigation Bar
//     gradientOfNavBar: LinearGradient(colors: [
//       ,
//       ,
//     ]),

//     // Other Apps
//     otherAppsElevatedButtonColor: ,
//     otherAppsPressedElevatedButtonColor: ,

//     // Basics
//     accentColor: ,
//     canTapCardColor: ,
//     tlDoubleCardBorderColor: ,
//     checkmarkColor: ,

//     // Alert
//     alertBackgroundColor: ,

//     // Category List
//     bigCategoryChipColor: ,

//     // Edit Page
//     toggleButtonsBackgroundColor: ,
//     toggleButtonsBackgroundSplashColor: ,
// );
