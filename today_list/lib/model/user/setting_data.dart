import 'package:flutter/material.dart';
import '../../dialogs/common/yes_no_dialog.dart';
import '../../dialogs/common/single_option_dialog.dart';
import '../external/tl_vibration.dart';
import '../external/tl_pref.dart';
import 'dart:convert';

class SettingData {
  static SettingData shared = SettingData(
      selectedThemeIndex: 0,
      defaultIconRarity: "Common",
      defaultIconName: "box",
      defaultIconCategory: "Default",
      isFirstEntry: true);

  // テーマ
  int selectedThemeIndex;
  // アイコン
  String defaultIconCategory;
  String defaultIconRarity;
  String defaultIconName;
  // チュートリアル
  bool isFirstEntry;

  // コンストラクタ
  SettingData({
    required this.selectedThemeIndex,
    required this.defaultIconRarity,
    required this.defaultIconName,
    required this.defaultIconCategory,
    required this.isFirstEntry,
  });

  // 保存する際に使う
  Map<String, dynamic> toJson() {
    return {
      "selectedThemeIndex": selectedThemeIndex,
      "defaultIconCategory": defaultIconCategory,
      "defaultIconRarity": defaultIconRarity,
      "defaultIconName": defaultIconName,
      "isFirstEntry": isFirstEntry,
    };
  }

  // JSONからインスタンスを作成するファクトリコンストラクタ
  factory SettingData.fromJson(Map<String, dynamic> jsonData) {
    return SettingData(
      selectedThemeIndex: jsonData["selectedThemeIndex"] ?? 0,
      defaultIconCategory: jsonData["defaultIconCategory"] ?? "Default",
      defaultIconRarity: jsonData["defaultIconRarity"] ?? "Common",
      defaultIconName: jsonData["defaultIconName"] ?? "box",
      isFirstEntry: jsonData["isFirstEntry"] ?? true,
    );
  }

  // 設定を読み込む関数
  Future<void> readSettings() async {
    await TLPref().getPref.then((pref) async {
      if (pref.getString("settingData") != null) {
        SettingData.shared =
            SettingData.fromJson(json.decode(pref.getString("settingData")!));
      } else {
        await shared.saveSettings();
      }
    });
  }

  // 全ての設定を保存する関数
  Future<void> saveSettings() async {
    await TLPref().getPref.then((pref) {
      pref.setString("settingData", json.encode(shared.toJson()));
    });
  }

  // チェックマークのアイコンを変える関数
  Future<void> askToSetDefaultIcon({
    required BuildContext context,
    required String iconCategoryName,
    required String iconRarity,
    required String iconName,
  }) async {
    // final bool isEarned = settingData.earnedIcons[iconCategoryName] != null &&
    //     settingData.earnedIcons[iconCategoryName]!.contains(iconName);
    // if (isEarned) {
    await showDialog(
        context: context,
        builder: (context) => YesNoDialog(
              title: "アイコンの変更",
              message: "チェックマークのアイコンを\n変更しますか?",
              yesAction: () {
                Navigator.pop(context);
                shared.defaultIconCategory = iconCategoryName;
                shared.defaultIconRarity = iconRarity;
                shared.defaultIconName = iconName;
                TLVibration.vibrate();
                showDialog(
                    context: context,
                    builder: (context) => SingleOptionDialog(
                          title: "変更が完了しました!",
                          message: null,
                        ));
                shared.saveSettings();
              },
            ));
    // } else {
    // await yesNoAlert(
    //   context: context,
    //   title: "PASSを獲得しよう!",
    //   message:
    //       "\n・広告を見てPASSの期間を増やすことでチェックボックスのアイコンを変更することができます\n\n・1回の動画広告で3日分獲得できます",
    //   yesAction: () => TLAds.showRewardedAd(
    //     rewardAction: () {
    //       TLAds.extendLimitOfPassReward(days: 3);
    //       simpleAlert(
    //           context: context,
    //           title: "PASSが延長されました!",
    //           message: "3日分のPASSを獲得しました",
    //           buttonText: "OK");
    //       setAppearancePageKey.currentState?.setState(() {});
    //     },
    //   ),
    // );
    // }
  }
}
