import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'dart:convert';

class TLWorkspaceReducer {
  static Future<List<TLWorkspace>> handle(List<TLWorkspace> workspaces,
      TLWorkspaceAction action, String currentWorkspaceID) async {
    List<TLWorkspace> updatedWorkspaces = action.map(
      changeCurrentWorkspaceID: (a) => workspaces,
      addWorkspace: (a) => _addWorkspace(workspaces, a.newWorkspace),
      removeWorkspace: (a) =>
          _removeWorkspace(workspaces, a.workspaceId, currentWorkspaceID),
      updateCurrentWorkspace: (a) => _updateCurrentWorkspace(
          workspaces, a.updatedWorkspace, currentWorkspaceID),
      updateWorkspaceList: (a) => a.updatedWorkspaceList,
    );

    await _saveWorkspaces(updatedWorkspaces);
    return updatedWorkspaces;
  }

  static List<TLWorkspace> _addWorkspace(
      List<TLWorkspace> workspaces, TLWorkspace newWorkspace) {
    return [...workspaces, newWorkspace];
  }

  static List<TLWorkspace> _removeWorkspace(List<TLWorkspace> workspaces,
      String workspaceId, String currentWorkspaceID) {
    final updatedWorkspaces =
        workspaces.where((workspace) => workspace.id != workspaceId).toList();

    // 現在のワークスペースが削除された場合、新しいデフォルトを設定
    if (workspaceId == currentWorkspaceID && updatedWorkspaces.isNotEmpty) {
      _saveCurrentWorkspaceID(updatedWorkspaces.first.id);
    }

    return updatedWorkspaces;
  }

  static List<TLWorkspace> _updateCurrentWorkspace(List<TLWorkspace> workspaces,
      TLWorkspace updatedWorkspace, String currentWorkspaceID) {
    return workspaces.map((workspace) {
      return workspace.id == currentWorkspaceID ? updatedWorkspace : workspace;
    }).toList();
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

  // --- Save Current Workspace ID ---
  static Future<void> _saveCurrentWorkspaceID(String id) async {
    final pref = await TLPrefService().getPref;
    await pref.setString('currentWorkspaceID', id);
  }
}
