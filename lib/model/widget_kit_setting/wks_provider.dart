import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_method_channel.dart';
import 'package:today_list/model/widget_kit_setting/widget_kit_setting.dart';
import 'package:today_list/model/external/tl_pref.dart';
import 'dart:convert';

import 'package:today_list/model/workspace/tl_workspaces_state.dart';

final widgetKitSettingsProvider =
    StateNotifierProvider<WidgetKitSettingNotifier, List<WidgetKitSetting>>(
        (ref) {
  return WidgetKitSettingNotifier(ref);
});

class WidgetKitSettingNotifier extends StateNotifier<List<WidgetKitSetting>> {
  final Ref ref;
  WidgetKitSettingNotifier(this.ref)
      : super([
          WidgetKitSetting(
              id: noneID,
              title: "Default",
              workspaceIdx: 0,
              bcIdx: 0,
              scIdx: null),
        ]) {
    // SharedPreferenceからデータを取得
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
    TLMethodChannel.updateWKSList(encodedWKSList: encodedWidgetKitSettings);
    await pref.setString("widgetKitSettings", encodedWidgetKitSettings);
  }

  // WKSを追加するメソッド
  Future<void> addWidgetKitSettings(
      {required WidgetKitSetting newWidgetKitSettings}) async {
    state = [...state, newWidgetKitSettings];
    await _saveWidgetKitSettings();
  }

  Future<void> removeWidgetKitSettings({required int index}) async {
    if (index < 0 || index >= state.length) {
      throw RangeError.index(index, state, 'index');
    }
    state = List.from(state)..removeAt(index);
    await _saveWidgetKitSettings();
  }

  // WKSListを更新するメソッド
  Future<void> updateWidgetKitSettingsList(
      {required List<WidgetKitSetting> updatedWidgetKitSettingsList}) async {
    state = updatedWidgetKitSettingsList;
    await _saveWidgetKitSettings();
  }
}
