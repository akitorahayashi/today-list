import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:today_list/model/external/tl_pref.dart';

class SettingData {
  static SettingData shared = SettingData(currentAppIconName: "Sun Orange");

  String currentAppIconName;

  SettingData({
    required this.currentAppIconName,
  });

  // JSONに変換するメソッド
  Map<String, dynamic> toJson() {
    return {
      'currentAppIconName': currentAppIconName,
    };
  }

  // JSONからインスタンスを生成するファクトリコンストラクタ
  factory SettingData.fromJson(Map<String, dynamic> json) {
    return SettingData(
        currentAppIconName: json['currentAppIconName'] ?? "Sun Orange");
  }

  Future<void> changeIcon({required String themeName}) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(themeName);
        SettingData.shared.currentAppIconName = themeName;
        SettingData.shared.saveSettingData();
        print('Icon changed to: $themeName');
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
  }

  // SharedPreferencesからデータを読み込むメソッド
  static Future<void> readSettingData() async {
    final pref = await TLPref().getPref;
    String? jsonString = pref.getString('settingData');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      shared = SettingData.fromJson(json);
    }
  }

  // SharedPreferencesにデータを保存するメソッド
  Future<void> saveSettingData() async {
    final pref = await TLPref().getPref;
    String jsonString = jsonEncode(toJson());
    await pref.setString('settingData', jsonString);
  }
}
