import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLToDoAction with _$TLToDoAction {
  // ToDo を追加
  const factory TLToDoAction.addToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) = _AddToDo;

  // ToDo を更新
  const factory TLToDoAction.updateToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) = _UpdateToDo;

  // ToDo を削除
  const factory TLToDoAction.deleteToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
  }) = _RemoveToDo;

  // ToDo のチェック状態を切り替え
  const factory TLToDoAction.toggleToDoCheckStatus({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
  }) = _ToggleToDoCheckStatus;

  // ToDo を Today <-> Whenever に移動
  const factory TLToDoAction.toggleToDoTodayWhenever({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
  }) = _ToggleToDoTodayWhenever;

  // ステップの並び替え
  const factory TLToDoAction.reorderSteps({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
    required int oldIndex,
    required int newIndex,
  }) = _ReorderSteps;

  // ステップのチェックの状態を切り替え
  const factory TLToDoAction.toggleStepCheckStatus({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
    required TLStep corrStep,
  }) = _ToggleStepCheckStatus;
}
