import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/widget_kit_setting/widget_kit_setting.dart';
import 'package:today_list/model/external/tl_pref.dart';
import 'dart:convert';

final widgetKitSettingsProvider =
    StateNotifierProvider<WidgetKitSettingNotifier, List<WidgetKitSetting>>(
        (ref) {
  return WidgetKitSettingNotifier(ref);
});

class WidgetKitSettingNotifier extends StateNotifier<List<WidgetKitSetting>> {
  final Ref ref;
  WidgetKitSettingNotifier(this.ref) : super([]) {
    // コンストラクタ、SharedPreferenceからデータを取得
    _loadWidgetKitSettings();
  }

  Future<void> _loadWidgetKitSettings() async {
    final pref = await TLPref().getPref;
    final encodedWidgetKitSettings = pref.getString("widgetKitSettings");
    if (encodedWidgetKitSettings != null) {
      final List<dynamic> jsonWidgetKitSettings =
          jsonDecode(encodedWidgetKitSettings);
      final List<WidgetKitSetting> savedTLWorkspaces =
          jsonWidgetKitSettings.map((j) {
        return WidgetKitSetting.fromJson(j);
      }).toList();
      state = savedTLWorkspaces;
    }
  }

  Future<void> _saveWidgetKitSettings() async {
    final pref = await TLPref().getPref;
    final encodedWidgetKitSettings =
        jsonEncode(state.map((w) => w.toJson()).toList());
    await pref.setString("widgetKitSettings", encodedWidgetKitSettings);
  }

  // TLWorkspaceを追加するメソッド
  Future<void> addWidgetKitSettings(
      {required WidgetKitSetting newWidgetKitSettings}) async {
    state = [...state, newWidgetKitSettings];
    await _saveWidgetKitSettings();
  }

  // TLWorkspaceを削除するメソッド
  Future<void> removeWidgetKitSettings(
      {required String corrWidgetKitSettingsId}) async {
    state = state.where((w) => w.id != corrWidgetKitSettingsId).toList();
    await _saveWidgetKitSettings();
  }

  // List<TLWorkspace>を更新するメソッド
  Future<void> updateWidgetKitSettingsList(
      {required List<WidgetKitSetting> updatedWidgetKitSettingsList}) async {
    state = updatedWidgetKitSettingsList;
    await _saveWidgetKitSettings();
  }
}
