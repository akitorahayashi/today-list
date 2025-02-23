import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_app_state_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLAppStateAction with _$TLAppStateAction {
  // 現在のWorkspaceIDを変更する
  const factory TLAppStateAction.changeCurrentWorkspaceID(String? newID) =
      ChangeCurrentWorkspaceID;

  // 選択したWorkspaceを保存する
  const factory TLAppStateAction.saveCorrWorkspace(
      TLWorkspace updatedWorkspace) = UpdateCurrentWorkspace;

  // TLWorkspacesを保存する
  const factory TLAppStateAction.saveWorkspaceList(
      List<TLWorkspace> updatedWorkspaceList) = UpdateWorkspaceList;
}
