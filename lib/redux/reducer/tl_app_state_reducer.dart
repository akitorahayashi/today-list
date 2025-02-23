import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/property/tl_theme_reducer.dart';
import 'package:today_list/redux/reducer/property/tl_todo_reducer.dart';
import 'package:today_list/redux/reducer/property/tl_workspace_reducer.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_pref.dart';
import 'dart:convert';

import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/reducer/property/tl_todo_category_reducer.dart';

class TLAppStateReducer extends StateNotifier<TLAppState> {
  TLAppStateReducer()
      : super(TLAppState(
          tlWorkspaces: initialTLWorkspaces,
          currentWorkspaceID: null,
        )) {
    _loadSavedAppState();
  }

  // MARK: - Load AppState
  Future<void> _loadSavedAppState() async {
    final pref = await TLPrefService().getPref;
    final savedWorkspaceID = pref.getString('currentWorkspaceID');

    final encodedWorkspaces = pref.getString("tlWorkspaces");
    if (encodedWorkspaces != null) {
      final List<dynamic> jsonWorkspaces = jsonDecode(encodedWorkspaces);
      final List<TLWorkspace> loadedWorkspaces = jsonWorkspaces.map((json) {
        return TLWorkspace.fromJson(json);
      }).toList();

      // 保存されたテーマを取得
      final themeName = pref.getString('themeType');
      final savedTheme = TLThemeType.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => TLThemeType.sunOrange, // デフォルト値
      );

      state = state.copyWith(
        tlWorkspaces: loadedWorkspaces,
        currentWorkspaceID: savedWorkspaceID,
        selectedThemeType: savedTheme,
      );
    }
  }

  // MARK: - Disp Theme A
  void dispatchThemeAction(TLThemeAction action) async {
    final newThemeType = await TLThemeReducer.handle(
      state.selectedThemeType,
      action,
    );
    state = state.copyWith(selectedThemeType: newThemeType);
  }

  // MARK: - Disp Workspace A
  Future<void> dispatchWorkspaceAction(TLWorkspaceAction action) async {
    List<TLWorkspace> updatedWorkspaces =
        await TLWorkspaceReducer.handle(state.tlWorkspaces, action);

    state = state.copyWith(tlWorkspaces: updatedWorkspaces);
  }

  // MARK: - Disp ToDo A
  Future<void> dispatchToDoAction(TLToDoAction action) async {
    List<TLWorkspace> updatedWorkspaces =
        await TLToDoReducer.reduce(state.tlWorkspaces, action);

    state = state.copyWith(tlWorkspaces: updatedWorkspaces);

    // Update Workspace List
    dispatchWorkspaceAction(
        TLWorkspaceAction.updateWorkspaceList(updatedWorkspaces));
  }

  // MARK: - Disp Category A
  Future<void> dispatchToDoCategoryAction(TLToDoCategoryAction action) async {
    List<TLWorkspace> updatedWorkspaces =
        await TLToDoCategoryReducer.reduce(state.tlWorkspaces, action);

    state = state.copyWith(tlWorkspaces: updatedWorkspaces);
    // カテゴリーの変更を保存
    dispatchWorkspaceAction(
      TLWorkspaceAction.updateWorkspaceList(updatedWorkspaces),
    );
  }

  // MARK: - Change Current Workspace ID
  TLAppState _changeCurrentWorkspaceID(String? newID) {
    if (state.currentWorkspaceID == newID) return state;

    _saveCurrentWorkspaceID(newID);
    TLVibrationService.vibrate();

    return state.copyWith(currentWorkspaceID: newID);
  }

  // --- Save Current Workspace ID ---
  Future<void> _saveCurrentWorkspaceID(String? id) async {
    final pref = await TLPrefService().getPref;
    if (id == null) {
      await pref.remove("currentWorkspaceID");
      print("Removed currentWorkspaceID");
    } else {
      await pref.setString('currentWorkspaceID', id);
    }
  }
}
