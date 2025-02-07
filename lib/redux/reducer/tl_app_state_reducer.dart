import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_workspace_reducer.dart';
import 'package:today_list/resource/initial_tl_workspaces.dart';
import 'package:today_list/service/tl_pref.dart';
import 'dart:convert';

import 'package:today_list/service/tl_vibration.dart';

class TLAppStateReducer extends StateNotifier<TLAppState> {
  TLAppStateReducer()
      : super(TLAppState(
            tlWorkspaces: initialTLWorkspaces, currentWorkspaceIndex: 0)) {
    _loadWorkspaces();
  }

  // --- Load Workspaces from Local Storage ---
  Future<void> _loadWorkspaces() async {
    final pref = await TLPrefService().getPref;
    final currentIndex = pref.getInt('currentWorkspaceIndex') ?? 0;

    final encodedWorkspaces = pref.getString("tlWorkspaces");
    if (encodedWorkspaces != null) {
      final List<dynamic> jsonWorkspaces = jsonDecode(encodedWorkspaces);
      final List<TLWorkspace> loadedWorkspaces = jsonWorkspaces.map((json) {
        return TLWorkspace.fromJson(json);
      }).toList();
      state = state.copyWith(
          tlWorkspaces: loadedWorkspaces, currentWorkspaceIndex: currentIndex);
    }
  }

  // --- Dispatch Todo Actions ---
  // void dispatchTodoAction(TLToDoAction action) {
  // state = state.copyWith(
  //   todos: RPTodosReducer.handle(state.todos, action),
  // );
  // }

  // --- Dispatch Workspace Actions ---
  Future<void> dispatchWorkspaceAction(TLWorkspaceAction action) async {
    List<TLWorkspace> updatedWorkspaces = await TLWorkspaceReducer.handle(
        state.tlWorkspaces, action, state.currentWorkspaceIndex);

    state = action.map(
      changeCurrentWorkspaceIndex: (a) =>
          _changeCurrentWorkspaceIndex(a.newIndex),
      addWorkspace: (a) => state.copyWith(tlWorkspaces: updatedWorkspaces),
      removeWorkspace: (a) => state.copyWith(tlWorkspaces: updatedWorkspaces),
      updateCurrentWorkspace: (a) =>
          state.copyWith(tlWorkspaces: updatedWorkspaces),
      updateWorkspaceList: (a) =>
          state.copyWith(tlWorkspaces: updatedWorkspaces),
    );
  }

  // --- Change Current Workspace Index ---
  TLAppState _changeCurrentWorkspaceIndex(int newIndex) {
    if (state.currentWorkspaceIndex == newIndex) return state; // 変更不要

    _saveCurrentWorkspaceIndex(newIndex);
    TLVibrationService.vibrate(); // バイブレーション

    return state.copyWith(currentWorkspaceIndex: newIndex);
  }

  // --- Save Current Workspace Index ---
  Future<void> _saveCurrentWorkspaceIndex(int index) async {
    final pref = await TLPrefService().getPref;
    await pref.setInt('currentWorkspaceIndex', index);
  }
}
