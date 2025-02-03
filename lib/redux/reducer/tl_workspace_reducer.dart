import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';

class TLWorkspaceReducer {
  static List<TLWorkspace> handle(List<TLWorkspace> workspaces,
      TLWorkspaceAction action, int currentIndex) {
    return action.map(
      changeCurrentWorkspaceIndex: (a) => workspaces,
      addWorkspace: (a) => _addWorkspace(workspaces, a.newWorkspace),
      removeWorkspace: (a) => _removeWorkspace(workspaces, a.workspaceId),
      updateCurrentWorkspace: (a) =>
          _updateCurrentWorkspace(workspaces, a.updatedWorkspace, currentIndex),
      updateWorkspaceList: (a) => a.updatedWorkspaceList,
    );
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
}
