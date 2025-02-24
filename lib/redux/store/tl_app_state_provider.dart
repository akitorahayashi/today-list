import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
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
    );
  }

  // MARK: - Action Handling
  Future<void> updateState(dynamic action) async {
    final newState = TLAppStateReducer.reduce(state, action);
    if (newState != state) {
      await _handleSideEffects(action, newState);
      state = newState;
    }
  }

  // MARK: - Side Effects
  Future<void> _handleSideEffects(dynamic action, TLAppState newState) async {
    TLVibrationService.vibrate();

    if (action is ChangeCurrentWorkspaceID) {
      await _saveCurrentWorkspaceID(action.newID);
    }

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
    final savedWorkspaceID = pref.getString('currentWorkspaceID');
    final encodedWorkspaces = pref.getString("tlWorkspaces");
    List<TLWorkspace> loadedWorkspaces = state.tlWorkspaces;

    if (encodedWorkspaces != null) {
      final List<dynamic> jsonWorkspaces = jsonDecode(encodedWorkspaces);
      loadedWorkspaces = jsonWorkspaces
          .map((json) => TLWorkspace.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    final themeName = pref.getString('themeType');
    final savedTheme = TLThemeType.values.firstWhere(
      (t) => t.name == themeName,
      orElse: () => TLThemeType.sunOrange,
    );

    state = state.copyWith(
      tlWorkspaces: loadedWorkspaces,
      currentWorkspaceID: savedWorkspaceID,
      selectedThemeType: savedTheme,
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

  Future<void> _saveTheme(TLThemeType themeType) async {
    final pref = await TLPrefService().getPref;
    await pref.setString('themeType', themeType.name);
  }
}
