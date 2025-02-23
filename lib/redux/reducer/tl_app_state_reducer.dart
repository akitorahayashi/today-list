import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_theme_reducer.dart';
import 'package:today_list/redux/reducer/tl_todo_category_reducer.dart';
import 'package:today_list/redux/reducer/tl_todo_reducer.dart';
import 'package:today_list/redux/reducer/tl_workspace_reducer.dart';

class TLAppStateReducer {
  static TLAppState reduce(TLAppState state, dynamic action) {
    if (action is TLAppStateAction) {
      return _reduceAppStateAction(state, action);
    } else if (action is TLWorkspaceAction) {
      return state.copyWith(
          tlWorkspaces: TLWorkspaceReducer.reduce(state.tlWorkspaces, action));
    } else if (action is TLToDoCategoryAction) {
      return state.copyWith(
          tlWorkspaces:
              TLToDoCategoryReducer.reduce(state.tlWorkspaces, action));
    } else if (action is TLToDoAction) {
      return state.copyWith(
          tlWorkspaces: TLToDoReducer.reduce(state.tlWorkspaces, action));
    } else if (action is TLThemeAction) {
      return state.copyWith(
          selectedThemeType:
              TLThemeReducer.reduce(state.selectedThemeType, action));
    }

    return state;
  }

  // MARK: - Reduce App State Action
  static TLAppState _reduceAppStateAction(
      TLAppState state, TLAppStateAction action) {
    return action.when(
      changeCurrentWorkspaceID: (newID) =>
          _changeCurrentWorkspaceID(state, newID),
      saveCorrWorkspace: (updatedWorkspace) =>
          _saveCorrWorkspace(state, updatedWorkspace),
      saveWorkspaceList: (updatedList) =>
          _saveWorkspaceList(state, updatedList),
    );
  }

  // MARK: - Private Methods
  static TLAppState _changeCurrentWorkspaceID(TLAppState state, String? newID) {
    return state.copyWith(currentWorkspaceID: newID);
  }

  static TLAppState _saveCorrWorkspace(
      TLAppState state, dynamic updatedWorkspace) {
    final List<TLWorkspace> updatedWorkspaces = state.tlWorkspaces
        .map((ws) => ws.id == updatedWorkspace.id ? updatedWorkspace : ws)
        .toList()
        .cast<TLWorkspace>();
    return state.copyWith(tlWorkspaces: updatedWorkspaces);
  }

  static TLAppState _saveWorkspaceList(
      TLAppState state, List<TLWorkspace> updatedList) {
    return state.copyWith(tlWorkspaces: updatedList);
  }
}
