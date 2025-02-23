import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';

class TLWorkspaceReducer {
  static List<TLWorkspace> reduce(
      List<TLWorkspace> workspaces, TLWorkspaceAction action) {
    List<TLWorkspace> updatedWorkspaces = action.map(
      addWorkspace: (a) => _addWorkspace(workspaces, a.newWorkspace),
      deleteWorkspace: (a) => _removeWorkspace(workspaces, a.corrWorkspace.id),
      deleteAllCheckedToDosInWorkspace: (a) =>
          _deleteAllCheckedToDosInWorkspace(workspaces, a.corrWorkspace),
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

  static List<TLWorkspace> _deleteAllCheckedToDosInWorkspace(
      List<TLWorkspace> workspaces, TLWorkspace corrWorkspace) {
    // `categoryIDToToDos` をコピーする
    final copiedCategoryIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
        corrWorkspace.categoryIDToToDos);

    // カテゴリーIDに対応するTLToDosInTodayAndWheneverの中のチェック済みToDoを削除
    for (String categoryID in copiedCategoryIDToToDos.keys) {
      final corrToDosInTodayAndWhenever = copiedCategoryIDToToDos[categoryID];
      if (corrToDosInTodayAndWhenever == null) continue;
      copiedCategoryIDToToDos[categoryID] = corrToDosInTodayAndWhenever
          .deleteAllCheckedToDosInAToDosList(isInToday: null);
    }

    // workspacesを更新して返す
    final corrWorkspaceIdx = workspaces.indexOf(corrWorkspace);
    if (corrWorkspaceIdx < 0) return workspaces; // 該当なし

    final updatedWorkspaces = List<TLWorkspace>.from(workspaces);
    updatedWorkspaces[corrWorkspaceIdx] = corrWorkspace.copyWith(
      categoryIDToToDos: copiedCategoryIDToToDos,
    );

    return updatedWorkspaces;
  }

  // --- Save Workspace to Local Storage ---

  // static List<TLWorkspace> _updateCorrWorkspace(
  //     List<TLWorkspace> workspaces, TLWorkspace updatedWorkspace) {
  //   return workspaces.map((workspace) {
  //     return workspace.id == updatedWorkspace.id ? updatedWorkspace : workspace;
  //   }).toList();
  // }

  // static Future<void> _saveWorkspaces(List<TLWorkspace> workspaces) async {
  //   final pref = await TLPrefService().getPref;
  //   final encodedWorkspaces =
  //       jsonEncode(workspaces.map((w) => w.toJson()).toList());

  //   await pref.setString("tlWorkspaces", encodedWorkspaces);
  //   TLMethodChannelService.updateTLWorkspaces(
  //       encodedTLWorkspaces: encodedWorkspaces);
  // }
}
