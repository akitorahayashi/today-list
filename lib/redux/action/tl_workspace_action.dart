import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part '../generate/tl_workspace_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLWorkspaceAction with _$TLWorkspaceAction {
  const factory TLWorkspaceAction.changeCurrentWorkspaceIndex(int newIndex) =
      ChangeCurrentWorkspaceIndex;

  const factory TLWorkspaceAction.addWorkspace(TLWorkspace newWorkspace) =
      AddWorkspace;

  const factory TLWorkspaceAction.removeWorkspace(String workspaceId) =
      RemoveWorkspace;

  const factory TLWorkspaceAction.updateCurrentWorkspace(
      TLWorkspace updatedWorkspace) = UpdateCurrentWorkspace;

  const factory TLWorkspaceAction.updateWorkspaceList(
      List<TLWorkspace> updatedWorkspaceList) = UpdateWorkspaceList;
}
