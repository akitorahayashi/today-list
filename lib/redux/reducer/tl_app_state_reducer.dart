import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/property/tl_theme_reducer.dart';
import 'package:today_list/redux/reducer/property/tl_todo_reducer.dart';
import 'package:today_list/redux/reducer/property/tl_user_data_reducer.dart';
import 'package:today_list/redux/reducer/property/tl_workspace_reducer.dart';

class TLAppStateReducer {
  static Future<TLAppState> reduce(TLAppState state, dynamic action) async {
    // TLAppStateAction
    if (action is TLAppStateAction) {
      return _reduceAppStateAction(state, action);
    }

    // TLWorkspaceAction
    if (action is TLWorkspaceAction) {
      return state.copyWith(
          tlWorkspaces: TLWorkspaceReducer.reduce(state.tlWorkspaces, action));
    }

    // TLToDoAction
    if (action is TLToDoAction) {
      return state.copyWith(
          tlWorkspaces: TLToDoReducer.reduce(state.tlWorkspaces, action));
    }

    // TLThemeAction
    if (action is TLThemeAction) {
      return state.copyWith(
          selectedThemeType:
              TLThemeReducer.reduce(state.selectedThemeType, action));
    }

    // TLUserDataAction
    if (action is TLUserDataAction) {
      return state.copyWith(
        tlUserData: await TLUserDataReducer.reduce(state.tlUserData, action),
      );
    }

    return state;
  }

  // MARK: - Reduce App State Action
  static TLAppState _reduceAppStateAction(
      TLAppState state, TLAppStateAction action) {
    return action.when(
      changeCurrentWorkspaceID: (newID) =>
          _changeCurrentWorkspaceID(state, newID),
      saveWorkspaceList: (updatedList) =>
          _saveWorkspaceList(state, updatedList),
      deleteAllCheckedToDosInTodayInWorkspaceList: (corrWorkspaceList) =>
          _deleteAllCheckedToDosInTodayInWorkspaceList(
              state, corrWorkspaceList),
    );
  }

  // MARK: - Private Methods
  static TLAppState _changeCurrentWorkspaceID(TLAppState state, String? newID) {
    return state.copyWith(currentWorkspaceID: newID);
  }

  static TLAppState _saveWorkspaceList(
      TLAppState state, List<TLWorkspace> updatedList) {
    return state.copyWith(tlWorkspaces: updatedList);
  }

  static TLAppState _deleteAllCheckedToDosInTodayInWorkspaceList(
      TLAppState state, List<TLWorkspace> corrWorkspaceList) {
    List<TLWorkspace> updatedWorkspaceList = [];
    for (TLWorkspace workspace in corrWorkspaceList) {
      final updatedWorkspace = workspace.copyWith(workspaceIDToToDos: workspace
          .workspaceIDToToDos
          .map((workspaceID, tlToDosInTodayAndWhenever) {
        return MapEntry(
            workspaceID,
            tlToDosInTodayAndWhenever.deleteAllCheckedToDosInAToDosList(
                isInToday: true));
      }));
      updatedWorkspaceList = [...updatedWorkspaceList, updatedWorkspace];
    }
    return state.copyWith(tlWorkspaces: updatedWorkspaceList);
  }
}
