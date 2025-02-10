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

class TLAppStateReducer extends StateNotifier<TLAppState> {
  TLAppStateReducer()
      : super(TLAppState(
          tlWorkspaces: initialTLWorkspaces,
          currentWorkspaceID: initialTLWorkspaces.isNotEmpty
              ? initialTLWorkspaces.first.id
              : noneID, // デフォルトワークスペースのID
        )) {
    _loadSavedAppState();
  }

  // --- Load Workspaces from Local Storage ---
  Future<void> _loadSavedAppState() async {
    final pref = await TLPrefService().getPref;
    final savedWorkspaceID = pref.getString('currentWorkspaceID') ?? noneID;

    final encodedWorkspaces = pref.getString("tlWorkspaces");
    if (encodedWorkspaces != null) {
      final List<dynamic> jsonWorkspaces = jsonDecode(encodedWorkspaces);
      final List<TLWorkspace> loadedWorkspaces = jsonWorkspaces.map((json) {
        return TLWorkspace.fromJson(json);
      }).toList();

      // 現在の ID に一致するワークスペースを探す
      final TLWorkspace validWorkspace = loadedWorkspaces.firstWhere(
        (w) => w.id == savedWorkspaceID,
        orElse: () => loadedWorkspaces.first,
      );

      // 保存されたテーマを取得
      final themeName = pref.getString('themeType');
      final savedTheme = TLThemeType.values.firstWhere(
        (e) => e.name == themeName,
        orElse: () => TLThemeType.sunOrange, // デフォルト値
      );

      state = state.copyWith(
        tlWorkspaces: loadedWorkspaces,
        currentWorkspaceID: validWorkspace.id,
        selectedThemeType: savedTheme,
      );
    }
  }

  // --- Dispatch Theme Actions ---
  void dispatchThemeAction(TLThemeAction action) {
    state = state.copyWith(
      selectedThemeType: TLThemeReducer.handle(state.selectedThemeType, action),
    );
  }

  // --- Dispatch Workspace Actions ---
  Future<void> dispatchWorkspaceAction(TLWorkspaceAction action) async {
    List<TLWorkspace> updatedWorkspaces = await TLWorkspaceReducer.handle(
        state.tlWorkspaces, action, state.currentWorkspaceID);

    state = action.map(
      changeCurrentWorkspaceID: (a) => _changeCurrentWorkspaceID(a.newID),
      addWorkspace: (a) => state.copyWith(tlWorkspaces: updatedWorkspaces),
      removeWorkspace: (a) => state.copyWith(tlWorkspaces: updatedWorkspaces),
      updateCurrentWorkspace: (a) =>
          state.copyWith(tlWorkspaces: updatedWorkspaces),
      updateWorkspaceList: (a) =>
          state.copyWith(tlWorkspaces: updatedWorkspaces),
    );
  }

  // MARK: - Dispatch ToDo Actions
  Future<void> dispatchToDoAction(TLToDoAction action) async {
    final updatedWorkspaces = action.map(
      addToDo: (a) => TLToDoReducer.addToDo(
        workspaces: state.tlWorkspaces,
        workspaceID: a.workspaceID,
        categoryID: a.categoryID,
        ifInToday: a.ifInToday,
        todo: a.todo,
      ),
      updateToDo: (a) => TLToDoReducer.updateToDo(
        workspaces: state.tlWorkspaces,
        workspaceID: a.workspaceID,
        categoryID: a.categoryID,
        ifInToday: a.ifInToday,
        index: a.index,
        newToDo: a.newToDo,
      ),
      removeToDo: (a) => TLToDoReducer.removeToDo(
        workspaces: state.tlWorkspaces,
        workspaceID: a.workspaceID,
        categoryID: a.categoryID,
        ifInToday: a.ifInToday,
        index: a.index,
      ),
    );

    // MARK: - Update State and Save
    dispatchWorkspaceAction(
        TLWorkspaceAction.updateWorkspaceList(updatedWorkspaces));
  }

  // --- Change Current Workspace ID ---
  TLAppState _changeCurrentWorkspaceID(String newID) {
    if (state.currentWorkspaceID == newID) return state; // 変更不要

    _saveCurrentWorkspaceID(newID);
    TLVibrationService.vibrate();

    return state.copyWith(currentWorkspaceID: newID);
  }

  // --- Save Current Workspace ID ---
  Future<void> _saveCurrentWorkspaceID(String id) async {
    final pref = await TLPrefService().getPref;
    await pref.setString('currentWorkspaceID', id);
  }
}
