import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/external/tl_pref.dart';
import '../../model/setting_data/setting_data.dart';
import 'dart:convert';

import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

final settingDataProvider =
    StateNotifierProvider<SettingDataNotifier, SettingData>(
  (ref) => SettingDataNotifier(),
);

class SettingDataNotifier extends StateNotifier<SettingData> {
  SettingDataNotifier() : super(SettingData(currentAppIconName: "Sun Orange")) {
    _loadSettingData();
  }

  Future<void> _loadSettingData() async {
    final pref = await TLPref().getPref;
    String? jsonString = pref.getString('settingData');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      state = SettingData.fromJson(json);
    }
  }

  // SharedPreferencesにデータを保存するメソッド
  Future<void> _saveSettingData() async {
    final pref = await TLPref().getPref;
    String jsonString = jsonEncode(state.toJson());
    await pref.setString('settingData', jsonString);
  }

  Future<void> changeIcon({required String themeName}) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(themeName);
        state = state.copyWith(currentAppIconName: themeName);
        _saveSettingData();
        print('Icon changed to: $themeName');
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
  }
}
