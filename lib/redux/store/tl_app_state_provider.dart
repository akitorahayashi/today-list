import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/tcw_settings.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tcw_action.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'dart:convert';

import 'package:today_list/util/tl_uuid_generator.dart';

// MARK: - Provider
final tlAppStateProvider = NotifierProvider<TLAppStateController, TLAppState>(
    TLAppStateController.new);

// MARK: - Notifier
class TLAppStateController extends Notifier<TLAppState> {
  @override
  TLAppState build() {
    _loadSavedAppState();
    return TLAppState(
      tlWorkspaces: initialTLWorkspaces,
      currentWorkspaceID: null,
      selectedThemeType: TLThemeType.sunOrange,
      tcwSettings: [
        TCWSettings(
          id: TLUUIDGenerator.generate(),
          title: "ProjectA",
          workspace: initialTLWorkspaces.first,
          bigCategory: initialTLWorkspaces.first.bigCategories.first,
          smallCategory: null,
        )
      ],
    );
  }

  // MARK: - Action Handling
  Future<void> updateState(dynamic action) async {
    TLVibrationService.vibrate();
    final newState = TLAppStateReducer.reduce(state, action);
    if (newState != state) {
      await _handleSideEffects(action, newState);
      state = newState;
    }
  }

  // MARK: - Side Effects
  Future<void> _handleSideEffects(dynamic action, TLAppState newState) async {
    // save TCWSettings
    if (action is TCWSettingsAction) {
      _saveTCWSettings(newState.tcwSettings);
    }

    // save currentWorkspaceID
    if (action is ChangeCurrentWorkspaceID) {
      await _saveCurrentWorkspaceID(action.newID);
    }

    // save workspaces
    if (action is TLWorkspaceAction ||
        action is TLToDoCategoryAction ||
        action is TLToDoAction ||
        (action is TLAppStateAction &&
            action.mapOrNull(saveWorkspaceList: (_) => true) == true) ||
        (action is TLAppStateAction &&
            action.mapOrNull(
                    deleteAllCheckedToDosInTodayInWorkspaceList: (_) => true) ==
                true)) {
      await _saveWorkspaces(newState.tlWorkspaces);
    }

    if (action is TLThemeAction) {
      await _saveTheme(newState.selectedThemeType);
    }
  }

  // MARK: - Initial Load
  Future<void> _loadSavedAppState() async {
    final pref = await TLPrefService().getPref;
    final stringWorkspaceID = pref.getString('currentWorkspaceID');
    final stringWorkspaces = pref.getString("tlWorkspaces");
    final stringTCWSettings = pref.getString("tcwSettings");
    List<TLWorkspace> loadedWorkspaces = state.tlWorkspaces;
    List<TCWSettings> loadedTCWSettings = state.tcwSettings;

    // decode workspaces
    if (stringWorkspaces != null) {
      final List<dynamic> jsonWorkspaces = jsonDecode(stringWorkspaces);
      loadedWorkspaces = jsonWorkspaces
          .map((json) => TLWorkspace.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    // decode TCWSettings
    if (stringTCWSettings != null) {
      final List<dynamic> jsonTCWSettings = jsonDecode(stringTCWSettings);
      loadedTCWSettings = jsonTCWSettings
          .map((json) => TCWSettings.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    // search theme
    final themeName = pref.getString('themeType');
    final savedTheme = TLThemeType.values.firstWhere(
      (t) => t.name == themeName,
      orElse: () => TLThemeType.sunOrange,
    );

    state = state.copyWith(
      selectedThemeType: savedTheme,
      currentWorkspaceID: stringWorkspaceID,
      tlWorkspaces: loadedWorkspaces,
      tcwSettings: loadedTCWSettings,
    );
  }

  // MARK: - Save State
  Future<void> _saveCurrentWorkspaceID(String? id) async {
    final pref = await TLPrefService().getPref;
    if (id == null) {
      await pref.remove("currentWorkspaceID");
    } else {
      await pref.setString('currentWorkspaceID', id);
    }
  }

  Future<void> _saveWorkspaces(List<TLWorkspace> workspaces) async {
    final pref = await TLPrefService().getPref;
    final encodedWorkspaces =
        jsonEncode(workspaces.map((w) => w.toJson()).toList());
    TCWiOSMethodChannelService.updateTLWorkspaces(
        encodedWorkspaces: encodedWorkspaces);
    await pref.setString("tlWorkspaces", encodedWorkspaces);
  }

  Future<void> _saveTCWSettings(List<TCWSettings> tcwSettings) async {
    final pref = await TLPrefService().getPref;
    final encodedTCWSettings =
        jsonEncode(tcwSettings.map((s) => s.toJson()).toList());
    TCWiOSMethodChannelService.updateListOfToDosInCategoryWidgetSettings(
        encodedListOfToDosInCategoryWidgetSettings: encodedTCWSettings);
    await pref.setString("tcwSettings", encodedTCWSettings);
  }

  Future<void> _saveTheme(TLThemeType themeType) async {
    final pref = await TLPrefService().getPref;
    await pref.setString('themeType', themeType.name);
  }
}
