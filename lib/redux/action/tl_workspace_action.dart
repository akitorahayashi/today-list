import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_workspace_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLWorkspaceAction with _$TLWorkspaceAction {
  // WorkspaceをtlWorkspacesに追加する
  const factory TLWorkspaceAction.addWorkspace(TLWorkspace newWorkspace) =
      AddWorkspace;

  // WorkspaceをtlWorkspacesから削除する
  const factory TLWorkspaceAction.deleteWorkspace(TLWorkspace corrWorkspace) =
      RemoveWorkspace;

  // Workspace内の全てのチェック済みToDoを削除する
  const factory TLWorkspaceAction.deleteAllCheckedToDosInWorkspace(
      String workspaceID) = DeleteAllCheckedToDosInWorkspace;
}
