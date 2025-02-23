import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_app_state_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLAppStateAction with _$TLAppStateAction {
  // 現在のWorkspaceIDを変更する
  const factory TLAppStateAction.changeCurrentWorkspaceID(String? newID) =
      ChangeCurrentWorkspaceID;

  // TLWorkspacesを保存する
  const factory TLAppStateAction.saveWorkspaceList(
      List<TLWorkspace> tlWorkspaces) = SaveWorkspaceList;

  // WorkspaceList内の今日に分類されているチェック済みのToDoを全て削除する
  const factory TLAppStateAction.deleteAllCheckedToDosInTodayInWorkspaceList(
          List<TLWorkspace> corrWorkspaceList) =
      DeleteAllCheckedToDosInTodayInWorkspaceList;
}
