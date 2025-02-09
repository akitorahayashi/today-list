import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/model/settings_data/todos_in_category_widget_settings.dart';
import 'package:today_list/service/tl_pref.dart';
import 'dart:convert';

final toDosInCategoryWidgetSettingsProvider = StateNotifierProvider<
    ToDosInCategoryWidgetSettingNotifier,
    List<ToDosInCategoryWidgetSettings>>((ref) {
  return ToDosInCategoryWidgetSettingNotifier(ref);
});

class ToDosInCategoryWidgetSettingNotifier
    extends StateNotifier<List<ToDosInCategoryWidgetSettings>> {
  final Ref ref;
  ToDosInCategoryWidgetSettingNotifier(this.ref)
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
    _loadToDosInCategoryWidgetSettings();
  }

  Future<void> _loadToDosInCategoryWidgetSettings() async {
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

  Future<void> _saveToDosInCategoryWidgetSettings() async {
    final pref = await TLPrefService().getPref;
    final encodedWidgetKitSettings =
        jsonEncode(state.map((w) => w.toJson()).toList());
    TLMethodChannelService.updateListOfToDosInCategoryWidgetSettings(
        encodedListOfToDosInCategoryWidgetSettings: encodedWidgetKitSettings);
    await pref.setString("widgetKitSettings", encodedWidgetKitSettings);
  }

  // WKSを追加するメソッド
  Future<void> addToDosInCategoryWidgetSettings(
      {required ToDosInCategoryWidgetSettings
          newToDosInCategoryWidgetSettings}) async {
    state = [...state, newToDosInCategoryWidgetSettings];
    await _saveToDosInCategoryWidgetSettings();
  }

  Future<void> removeToDosInCategoryWidgetSettings({required String id}) async {
    final index = state.indexWhere((element) => element.id == id);
    if (index == -1) {
      throw ArgumentError('IDが見つかりません: $id');
    }
    state = List.from(state)..removeAt(index);
    await _saveToDosInCategoryWidgetSettings();
  }

  // WKSListを更新するメソッド
  Future<void> updateToDosInCategoryWidgetSettingsList(
      {required List<ToDosInCategoryWidgetSettings>
          updatedWidgetKitSettingsList}) async {
    state = updatedWidgetKitSettingsList;
    await _saveToDosInCategoryWidgetSettings();
  }
}
