import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/service/tl_pref.dart';
import 'dart:convert';

final widgetKitSettingsProvider = StateNotifierProvider<
    WidgetKitSettingNotifier, List<ToDosInCategoryWidgetSettings>>((ref) {
  return WidgetKitSettingNotifier(ref);
});

class WidgetKitSettingNotifier
    extends StateNotifier<List<ToDosInCategoryWidgetSettings>> {
  final Ref ref;
  WidgetKitSettingNotifier(this.ref)
      : super([
          ToDosInCategoryWidgetSettings(
            id: noneID,
            title: "Default",
            workspace: ref.read(tlAppStateProvider).tlWorkspaces[0],
            bigCategory:
                ref.read(tlAppStateProvider).tlWorkspaces[0].bigCategories[0],
            smallCategory: null,
          ),
        ]) {
    // SharedPreferenceからデータを取得
    _loadWidgetKitSettings();
  }

  Future<void> _loadWidgetKitSettings() async {
    final pref = await TLPrefService().getPref;
    final encodedWidgetKitSettings = pref.getString("widgetKitSettings");
    if (encodedWidgetKitSettings != null) {
      final List<dynamic> jsonWidgetKitSettings =
          jsonDecode(encodedWidgetKitSettings);
      final List<ToDosInCategoryWidgetSettings> savedTLWorkspaces =
          jsonWidgetKitSettings.map((j) {
        return ToDosInCategoryWidgetSettings.fromJson(j);
      }).toList();
      state = savedTLWorkspaces;
    }
  }

  Future<void> _saveWidgetKitSettings() async {
    final pref = await TLPrefService().getPref;
    final encodedWidgetKitSettings =
        jsonEncode(state.map((w) => w.toJson()).toList());
    TLMethodChannelService.updateListOfToDosInCategoryWidgetSettings(
        encodedListOfToDosInCategoryWidgetSettings: encodedWidgetKitSettings);
    await pref.setString("widgetKitSettings", encodedWidgetKitSettings);
  }

  // WKSを追加するメソッド
  Future<void> addWidgetKitSettings(
      {required ToDosInCategoryWidgetSettings newWidgetKitSettings}) async {
    state = [...state, newWidgetKitSettings];
    await _saveWidgetKitSettings();
  }

  Future<void> removeWidgetKitSettings({required String id}) async {
    final index = state.indexWhere((element) => element.id == id);
    if (index == -1) {
      throw ArgumentError('IDが見つかりません: $id');
    }
    state = List.from(state)..removeAt(index);
    await _saveWidgetKitSettings();
  }

  // WKSListを更新するメソッド
  Future<void> updateWidgetKitSettingsList(
      {required List<ToDosInCategoryWidgetSettings>
          updatedWidgetKitSettingsList}) async {
    state = updatedWidgetKitSettingsList;
    await _saveWidgetKitSettings();
  }
}
