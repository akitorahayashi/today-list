// ignore_for_file: invalid_use_of_protected_member
import 'package:today_list/model/externals/tl_widgetkit.dart';

import '../../constants/global_keys.dart';
import '../../constants/theme.dart';
import '../../alerts/yes_no_alert.dart';
import '../../alerts/simple_alert.dart';
import '../externals/tl_vibration.dart';
import '../../styles.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

class SettingData {
  static SettingData shared = SettingData();

  // テーマ
  String selectedTheme = "Sun Orange";
  // 英語モード
  bool englishMode = true;
  // アイコン
  String defaultIconCategory = "Default";
  String defaultIconRarity = "Common";
  String defaultIconName = "box";
  // チュートリアル
  bool isFirstEntry = true;

  // コンストラクタ
  SettingData();

  // 保存する際に使う
  Map<String, dynamic> toJson() {
    return {
      "selectedTheme": selectedTheme,
      "englishMode": englishMode,
      "defaultIconCategory": defaultIconCategory,
      "defaultIconRarity": defaultIconRarity,
      "defaultIconName": defaultIconName,
      "isFirstEntry": isFirstEntry,
    };
  }

  // JSONからインスタンスを作成するファクトリコンストラクタ
  factory SettingData.fromJson(Map<String, dynamic> jsonData) {
    return SettingData()
      ..selectedTheme = jsonData["selectedTheme"] ?? "Sun Orange"
      ..englishMode = jsonData["englishMode"] ?? true
      ..defaultIconCategory = jsonData["defaultIconCategory"] ?? "Default"
      ..defaultIconRarity = jsonData["defaultIconRarity"] ?? "Common"
      ..defaultIconName = jsonData["defaultIconName"] ?? "box"
      ..isFirstEntry = jsonData["isFirstEntry"] ?? true;
  }

  // 設定を読み込む関数
  Future<void> readSettings() async {
    await SharedPreferences.getInstance().then((pref) async {
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
    await SharedPreferences.getInstance().then((pref) {
      pref.setString("settingData", json.encode(shared.toJson()));
    });
  }

  // テーマを変更する関数
  Future<void> confirmToChangeTheme(
      {required BuildContext context, required String themeName}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: theme[themeName]!.alertColor,
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.black45),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // テーマの模型
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: SizedBox(
                      width: 250,
                      height: 80,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: theme[themeName]!.gradientOfNavBar,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GlassContainer(
                          child: Align(
                            alignment: Alignment.center,
                            child: Card(
                              elevation: 5,
                              color: theme[themeName]!.panelColor,
                              child: Container(
                                width: 150,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  themeName,
                                  style: TextStyle(
                                      color: theme[themeName]!.checkmarkColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text("$themeNameに変更しますか？"),
                  ),
                  // 操作ボタン
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 戻るボタン
                      TextButton(
                        style: alertButtonStyle(),
                        onPressed: () => Navigator.pop(context),
                        // InkWell
                        child: Text(
                          "戻る",
                          style:
                              TextStyle(color: theme[themeName]!.accentColor),
                        ),
                      ),
                      // 変更するボタン
                      TextButton(
                          style: alertButtonStyle(),
                          onPressed: () {
                            // このアラートを消す
                            Navigator.pop(context);
                            shared.selectedTheme = themeName;
                            TLWidgetKit.updateSelectedTheme();
                            todayListAppKey.currentState?.setState(() {});
                            setAppearancePageKey.currentState?.setState(() {});
                            TLVibration.vibrate();
                            // thank youアラート
                            simpleAlert(
                              context: context,
                              title: "変更が完了しました!",
                              message: null,
                              buttonText: "OK",
                            );

                            shared.saveSettings();
                          },
                          // InkWell
                          child: Text("変更",
                              style: TextStyle(
                                  color: theme[themeName]!.accentColor))),
                    ],
                  )
                ],
              ),
            ),
          );
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
    await yesNoAlert(
      context: context,
      title: "アイコンの変更",
      message: "チェックマークのアイコンを\n変更しますか?",
      yesAction: () {
        Navigator.pop(context);
        // if (settingData.userLevel >= 10) {
        shared.defaultIconCategory = iconCategoryName;
        shared.defaultIconRarity = iconRarity;
        shared.defaultIconName = iconName;
        todayListAppKey.currentState?.setState(() {});
        setAppearancePageKey.currentState?.setState(() {});
        TLVibration.vibrate();
        simpleAlert(
            context: context,
            title: "変更が完了しました!",
            message: null,
            buttonText: "OK");
        shared.saveSettings();
      },
    );
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
