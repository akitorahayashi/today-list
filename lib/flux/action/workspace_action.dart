import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/workspace_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class WorkspaceAction with _$WorkspaceAction {
  // WorkspaceをtlWorkspacesに追加する
  const factory WorkspaceAction.addWorkspace(TLWorkspace newWorkspace) =
      AddWorkspace;

  // WorkspaceをtlWorkspacesから削除する
  const factory WorkspaceAction.deleteWorkspace(String workspaceId) =
      DeleteWorkspace;

  // Workspace内の全てのチェック済みToDoを削除する
  const factory WorkspaceAction.deleteAllCheckedToDosInWorkspace(
      TLWorkspace workspace) = DeleteAllCheckedToDosInWorkspace;

  // 選択したWorkspaceを保存する
  const factory WorkspaceAction.updateWorkspace(TLWorkspace workspace) =
      UpdateWorkspace;

  // ワークスペースの並び替え
  const factory WorkspaceAction.reorderWorkspace({
    required int oldIndex,
    required int newIndex,
  }) = ReorderWorkspace;

  // 今日のチェック済みToDoをすべて削除（全ワークスペース対象）
  const factory WorkspaceAction.deleteAllCheckedToDosInToday(
      List<TLWorkspace> workspaces) = DeleteAllCheckedToDosInToday;
}
