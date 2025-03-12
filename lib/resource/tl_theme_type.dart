import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

part 'generate/tl_theme_type.g.dart';

// $ dart run build_runner build

@JsonEnum(alwaysCreate: true)
enum TLThemeType {
  @JsonValue("notebook")
  notebook(
    TLThemeConfig(
      // Theme Name
      themeName: "Notebook",
      themeTitleInSettings: "Notebook",
      navigationTitleColor: Color.fromRGBO(130, 130, 130, 1),

      // Settings Page
      titleColorOfSettingPage: Color.fromRGBO(130, 130, 130, 1),
      settingPanelColor: Color.fromRGBO(250, 250, 250, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(240, 240, 240, 1),
          Color.fromRGBO(250, 250, 250, 1),
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(20, 240, 240, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(210, 210, 210, 1),

      // Basics
      accentColor: Color.fromRGBO(94, 158, 214, 1),
      canTapCardColor: Color.fromRGBO(240, 240, 240, 1),
      whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
      tlDoubleCardBorderColor: Color.fromRGBO(230, 230, 230, 1),

      // Alert
      alertBackgroundColor: Color.fromRGBO(248, 248, 248, 1),

      // Category List
      bigCategoryChipColor: Color.fromRGBO(240, 240, 240, 1),

      // Edit Page
      toggleButtonsBackgroundColor: Color.fromRGBO(240, 240, 240, 0.5),
      toggleButtonsBackgroundSplashColor: Color.fromRGBO(220, 220, 220, 0.5),
    ),
  ),

  @JsonValue("sunOrange")
  sunOrange(
    // config:
    TLThemeConfig(
      // Theme Name
      themeName: "Sun Orange",
      themeTitleInSettings: "Sun\nOrange",

      // Settings Page
      navigationTitleColor: Colors.white,
      settingPanelColor: Color.fromRGBO(255, 243, 184, 1),
      titleColorOfSettingPage: Color.fromRGBO(170, 119, 80, 1),
      // Home Page
      backgroundColor: Color.fromRGBO(255, 229, 214, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(255, 163, 163, 1),
          Color.fromRGBO(255, 230, 87, 1),
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(255, 192, 97, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 222, 173, 1),

      // Basics
      accentColor: Colors.orange,
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

  @JsonValue("limeGreen")
  limeGreen(
    TLThemeConfig(
      // Theme Name
      themeName: "Lime Green",
      themeTitleInSettings: "Lime\nGreen",

      // Settings Page
      navigationTitleColor: Colors.white,
      titleColorOfSettingPage: Color.fromRGBO(130, 81, 43, 1),
      settingPanelColor: Color.fromRGBO(223, 168, 139, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(239, 255, 214, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(73, 194, 70, 1),
          Color.fromRGBO(143, 250, 56, 1),
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(138, 231, 101, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(195, 243, 176, 1),

      // Basics
      accentColor: Colors.lightGreen,
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
      navigationTitleColor: Colors.white,
      titleColorOfSettingPage: Colors.cyan,
      settingPanelColor: Color.fromRGBO(219, 248, 255, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(241, 251, 253, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(131, 169, 252, 1),
          Color.fromRGBO(144, 242, 249, 1),
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(89, 211, 227, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(163, 231, 239, 1),

      // Basics
      accentColor: Colors.cyan,
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

  // @JsonValue("goldenEbony")
  // goldenEbony(
  //   TLThemeConfig(
  //     // Theme Name
  //     themeName: "Golden Ebony",
  //     themeTitleInSettings: "Golden\nEbony",

  //     // Settings Page
  //     navigationTitleColor: Colors.white,
  //     titleColorOfSettingPage: Color.fromRGBO(50, 50, 50, 1),
  //     settingPanelColor: Color.fromRGBO(240, 240, 240, 1),

  //     // Home Page
  //     backgroundColor: Color.fromRGBO(248, 248, 248, 1),

  //     // Navigation Bar
  //     gradientOfNavBar: LinearGradient(colors: [
  //       Color.fromRGBO(70, 70, 70, 1),
  //       Color.fromRGBO(50, 50, 50, 1),
  //     ]),

  //     // Other Apps
  //     otherAppsElevatedButtonColor: Color.fromRGBO(80, 80, 80, 1),
  //     otherAppsPressedElevatedButtonColor: Color.fromRGBO(120, 120, 120, 1),

  //     // Basics
  //     defaultAccentColor: Color.fromRGBO(204, 152, 8, 1),
  //     canTapCardColor: Color.fromRGBO(235, 235, 235, 1),
  //     whiteBasedColor: Color.fromRGBO(255, 255, 255, 1),
  //     tlDoubleCardBorderColor: Color.fromRGBO(200, 200, 200, 1),

  //     // Alert
  //     alertBackgroundColor: Color.fromRGBO(240, 240, 240, 1),

  //     // Category List
  //     bigCategoryChipColor: Color.fromRGBO(80, 80, 80, 1),

  //     // Edit Page
  //     toggleButtonsBackgroundColor: Color.fromRGBO(220, 220, 220, 0.5),
  //     toggleButtonsBackgroundSplashColor: Color.fromRGBO(180, 180, 180, 0.5),
  //   ),
  // ),

  @JsonValue("cherryBlossom")
  cherryBlossom(
    TLThemeConfig(
      // Theme Name
      themeName: "Cherry Blossom",
      themeTitleInSettings: "Cherry\nBlossom",

      // Settings Page
      navigationTitleColor: Colors.white,
      titleColorOfSettingPage: Color.fromRGBO(219, 112, 147, 1),
      settingPanelColor: Color.fromRGBO(255, 240, 245, 1),

      // Home Page
      backgroundColor: Color.fromRGBO(253, 245, 247, 1),

      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(255, 182, 193, 1),
          Color.fromRGBO(255, 192, 203, 1),
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(255, 182, 193, 1),
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 218, 224, 1),

      // Basics
      accentColor: Color.fromRGBO(240, 152, 147, 1),
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

  @JsonValue("pastryBloom")
  pastryBloom(
    TLThemeConfig(
      // Theme Name
      themeName: "Pastry Bloom",
      themeTitleInSettings: "Pastry\nBloom",

      // Settings Page
      navigationTitleColor: Colors.white,
      titleColorOfSettingPage: Color.fromRGBO(165, 117, 98, 1),
      settingPanelColor: Color.fromRGBO(252, 250, 242, 1), // Cream color
      // Home Page
      backgroundColor: Color.fromRGBO(255, 252, 245, 1), // Light cream
      // Navigation Bar
      gradientOfNavBar: LinearGradient(
        colors: [
          Color.fromRGBO(255, 223, 186, 1), // Light peach
          Color.fromRGBO(255, 236, 210, 1), // Lighter peach
        ],
      ),

      // Other Apps
      otherAppsElevatedButtonColor: Color.fromRGBO(
        255,
        213,
        158,
        1,
      ), // Soft orange
      otherAppsPressedElevatedButtonColor: Color.fromRGBO(255, 228, 196, 1),

      // Basics
      accentColor: Colors.amber,
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
  static TLThemeType fromJson(String json) =>
      _$TLThemeTypeEnumMap.entries
          .firstWhere(
            (e) => e.value == json,
            orElse:
                () => _$TLThemeTypeEnumMap.entries.firstWhere(
                  (e) => e.key == TLThemeType.notebook, // デフォルトを指定
                ),
          )
          .key;

  String toJson() => _$TLThemeTypeEnumMap[this] ?? 'notebook';
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
