import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'dart:convert';

class TLWorkspaceReducer {
  static List<TLWorkspace> handle(
      List<TLWorkspace> workspaces, TLWorkspaceAction action) {
    List<TLWorkspace> updatedWorkspaces = action.map(
      changeCurrentWorkspaceID: (a) => workspaces,
      addWorkspace: (a) => _addWorkspace(workspaces, a.newWorkspace),
      deleteWorkspace: (a) => _removeWorkspace(workspaces, a.corrWorkspace.id),
      deleteAllCheckedToDosInWorkspace: ,
      updateCorrWorkspace: (a) =>
          _updateCorrWorkspace(workspaces, a.updatedWorkspace),
      updateWorkspaceList: (a) => a.updatedWorkspaceList,
    );

    return updatedWorkspaces;
  }

  static List<TLWorkspace> _addWorkspace(
      List<TLWorkspace> workspaces, TLWorkspace newWorkspace) {
    return [...workspaces, newWorkspace];
  }

  static List<TLWorkspace> _removeWorkspace(
      List<TLWorkspace> workspaces, String workspaceId) {
    final updatedWorkspaces =
        workspaces.where((workspace) => workspace.id != workspaceId).toList();

    return updatedWorkspaces;
  }

  // --- Save Workspace to Local Storage ---

  static List<TLWorkspace> _updateCorrWorkspace(
      List<TLWorkspace> workspaces, TLWorkspace updatedWorkspace) {
    return workspaces.map((workspace) {
      return workspace.id == updatedWorkspace.id ? updatedWorkspace : workspace;
    }).toList();
  }

  static Future<void> _saveWorkspaces(List<TLWorkspace> workspaces) async {
    final pref = await TLPrefService().getPref;
    final encodedWorkspaces =
        jsonEncode(workspaces.map((w) => w.toJson()).toList());

    await pref.setString("tlWorkspaces", encodedWorkspaces);
    TLMethodChannelService.updateTLWorkspaces(
        encodedTLWorkspaces: encodedWorkspaces);
  }
}
