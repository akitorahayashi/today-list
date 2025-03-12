import 'package:freezed_annotation/freezed_annotation.dart';

part 'generate/current_workspace_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class CurrentWorkspaceAction with _$CurrentWorkspaceAction {
  // 現在のWorkspaceIDを変更する
  const factory CurrentWorkspaceAction.setCurrentWorkspaceId(
      String? workspaceId) = SetCurrentWorkspaceId;
}
