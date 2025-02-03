import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';

part 'generate/tl_todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
class TLToDoAction with _$TLToDoAction {
  /// ToDo の編集を開始する
  const factory TLToDoAction.startEditingToDo({
    required String categoryId,
    required String? smallCategoryId,
    required int indexOfEditingToDo,
    required bool ifInToday,
  }) = StartEditingToDoAction;

  /// ToDo のタイトルを更新
  const factory TLToDoAction.updateToDoTitle({
    required String newTitle,
  }) = UpdateToDoTitleAction;

  /// ToDo のステップを追加
  const factory TLToDoAction.addStep({
    required String stepTitle,
  }) = AddStepAction;

  /// ToDo の編集を完了する
  const factory TLToDoAction.completeEditing() = CompleteEditingToDoAction;

  /// 編集中のToDoをリセット（キャンセル）
  const factory TLToDoAction.resetEditingToDo() = ResetEditingToDoAction;
}
