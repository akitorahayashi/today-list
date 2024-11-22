import '../external/tl_pref.dart';
import 'dart:convert';

class SettingData {
  static SettingData shared = SettingData(isFirstEntry: true);

  // チュートリアル
  bool isFirstEntry;

  // コンストラクタ
  SettingData({
    required this.isFirstEntry,
  });

  // 保存する際に使う
  Map<String, dynamic> toJson() {
    return {
      "isFirstEntry": isFirstEntry,
    };
  }

  // JSONからインスタンスを作成するファクトリコンストラクタ
  factory SettingData.fromJson(Map<String, dynamic> jsonData) {
    return SettingData(
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
}
