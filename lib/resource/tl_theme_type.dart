import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

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
      defaultAccentColor: Colors.orange,
      canTapCardColor: Color.fromRGBO(235, 255, 179, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(255, 192, 97, 1),

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
      defaultAccentColor: Colors.lightGreen,
      canTapCardColor: Color.fromRGBO(255, 253, 184, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(225, 163, 102, 1),

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
      defaultAccentColor: Colors.cyan,
      canTapCardColor: Color.fromRGBO(214, 252, 255, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(129, 221, 234, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(240, 248, 255, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(133, 214, 255, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Colors.lightBlue,
      toggleButtonsBackgroundSplashColor: Colors.lightBlue,
    ),
  ),

  @JsonValue("monochrome")
  monochrome(
    TLThemeConfig(
      // Theme Name
      themeName: "Monochrome",
      themeTitleInSettings: "Mono\nchrome",

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(50, 50, 50, 1),
      settingPanelColor: Color.fromRGBO(240, 240, 240, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(70, 70, 70, 1),
        Color.fromRGBO(40, 40, 40, 1),
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(80, 80, 80, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(120, 120, 120, 1),

      // Basics
      defaultAccentColor: Colors.grey,
      canTapCardColor: Color.fromRGBO(245, 245, 245, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(200, 200, 200, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(240, 240, 240, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(80, 80, 80, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(220, 220, 220, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(180, 180, 180, 0.5),
    ),
  ),

  @JsonValue("cherryBlossom")
  cherryBlossom(
    TLThemeConfig(
      // Theme Name
      themeName: "Cherry Blossom",
      themeTitleInSettings: "Cherry\nBlossom",

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(219, 112, 147, 1),
      settingPanelColor: Color.fromRGBO(255, 240, 245, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(253, 245, 247, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(255, 182, 193, 1),
        Color.fromRGBO(255, 192, 203, 1),
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(255, 182, 193, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 218, 224, 1),

      // Basics
      defaultAccentColor: Colors.pink,
      canTapCardColor: Color.fromRGBO(255, 245, 250, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(255, 192, 203, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(255, 240, 245, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(255, 182, 193, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(255, 228, 225, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(255, 218, 224, 0.5),
    ),
  ),

  @JsonValue("urbanNight")
  urbanNight(
    TLThemeConfig(
      // Theme Name
      themeName: "Urban Night",
      themeTitleInSettings: "Urban\nNight",

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(156, 220, 254, 1), // VSCode blue
      settingPanelColor:
          Color.fromRGBO(37, 37, 38, 1), // VSCode Dark+ background

      // Home Page
      backgroundColor: Color.fromRGBO(30, 30, 30, 1), // VSCode Dark+ background

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(33, 33, 33, 1), // Dark gray
        Color.fromRGBO(15, 15, 15, 1), // Darker gray
      ]),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(68, 68, 68, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(51, 51, 51, 1),

      // Basics
      defaultAccentColor: Colors.blue,
      canTapCardColor: Color.fromRGBO(45, 45, 45, 1),
      whiteBasedColor: Color.fromRGBO(204, 204, 204, 1), // VSCode text color
      tlDoubleCardBorderColor: Color.fromRGBO(85, 85, 85, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(37, 37, 38, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(78, 120, 160, 1), // Muted blue

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(78, 120, 160, 0.3),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(78, 120, 160, 0.5),
    ),
  ),

  @JsonValue("patisserie")
  patisserie(
    TLThemeConfig(
      // Theme Name
      themeName: "Patisserie",
      themeTitleInSettings: "Patis\nserie",

      // Settings Page
      titleColorOfSettingPage:
          Color.fromRGBO(165, 117, 98, 1), // Chocolate brown
      settingPanelColor: Color.fromRGBO(252, 250, 242, 1), // Cream color

      // Home Page
      backgroundColor: Color.fromRGBO(255, 252, 245, 1), // Light cream

      // Navigation Bar
      gradientOfNavBar: LinearGradient(colors: [
        Color.fromRGBO(255, 223, 186, 1), // Light peach
        Color.fromRGBO(255, 236, 210, 1), // Lighter peach
      ]),

      // Other Apps
      otherAppsElevatedButtonColor:
          Color.fromRGBO(255, 213, 158, 1), // Soft orange
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 228, 196, 1),

      // Basics
      defaultAccentColor: Colors.amber,
      canTapCardColor: Color.fromRGBO(255, 248, 225, 1), // Very light yellow
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(255, 213, 158, 1), // Soft orange

      // Alert
      alertBackgroundColor: Color.fromRGBO(255, 248, 225, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(255, 213, 158, 1), // Soft orange

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(255, 228, 196, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(255, 213, 158, 0.5),
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
