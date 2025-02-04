import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'dart:convert';

class TLWorkspaceReducer {
  static Future<List<TLWorkspace>> handle(List<TLWorkspace> workspaces,
      TLWorkspaceAction action, int currentIndex) async {
    List<TLWorkspace> updatedWorkspaces = action.map(
      changeCurrentWorkspaceIndex: (a) => workspaces,
      addWorkspace: (a) => _addWorkspace(workspaces, a.newWorkspace),
      removeWorkspace: (a) => _removeWorkspace(workspaces, a.workspaceId),
      updateCurrentWorkspace: (a) =>
          _updateCurrentWorkspace(workspaces, a.updatedWorkspace, currentIndex),
      updateWorkspaceList: (a) => a.updatedWorkspaceList,
    );

    await _saveWorkspaces(updatedWorkspaces);
    return updatedWorkspaces;
  }

  static List<TLWorkspace> _addWorkspace(
      List<TLWorkspace> workspaces, TLWorkspace newWorkspace) {
    return [...workspaces, newWorkspace];
  }

  static List<TLWorkspace> _removeWorkspace(
      List<TLWorkspace> workspaces, String workspaceId) {
    return workspaces
        .where((workspace) => workspace.id != workspaceId)
        .toList();
  }

  static List<TLWorkspace> _updateCurrentWorkspace(List<TLWorkspace> workspaces,
      TLWorkspace updatedWorkspace, int currentIndex) {
    if (currentIndex < 0 || currentIndex >= workspaces.length) {
      return workspaces;
    }
    final updatedList = List<TLWorkspace>.from(workspaces);
    updatedList[currentIndex] = updatedWorkspace;
    return updatedList;
  }

  // --- Save Workspaces to Local Storage ---
  static Future<void> _saveWorkspaces(List<TLWorkspace> workspaces) async {
    final pref = await TLPrefService().getPref;
    final encodedWorkspaces =
        jsonEncode(workspaces.map((w) => w.toJson()).toList());

    await pref.setString("tlWorkspaces", encodedWorkspaces);
    TLMethodChannelService.updateTLWorkspaces(
        encodedTLWorkspaces: encodedWorkspaces);
  }
}
