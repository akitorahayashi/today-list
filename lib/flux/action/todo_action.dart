import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_step.dart';

part 'generate/todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
class TodoAction with _$TodoAction {
  const factory TodoAction.addTodo({
    required TLWorkspace workspace,
    required TLToDo todo,
  }) = _AddTodo;

  const factory TodoAction.updateTodo({
    required TLWorkspace workspace,
    required TLToDo todo,
  }) = _UpdateTodo;

  const factory TodoAction.deleteTodo({
    required TLWorkspace workspace,
    required TLToDo todo,
    required bool ifInToday,
  }) = _DeleteTodo;

  const factory TodoAction.toggleTodoCheck({
    required TLWorkspace workspace,
    required TLToDo todo,
    required bool ifInToday,
  }) = _ToggleTodoCheck;

  const factory TodoAction.reorderTodos({
    required TLWorkspace workspace,
    required List<TLToDo> todos,
    required int oldIndex,
    required int newIndex,
    required String category,
    required bool ifInToday,
  }) = _ReorderTodos;

  const factory TodoAction.deleteAllCheckedTodos({
    required TLWorkspace workspace,
    required bool ifInToday,
  }) = _DeleteAllCheckedTodos;

  // Step関連のアクション
  const factory TodoAction.toggleStepCheck({
    required TLWorkspace workspace,
    required TLToDo todo,
    required TLStep step,
  }) = _ToggleStepCheck;

  const factory TodoAction.toggleTodoTodayWhenever({
    required TLWorkspace workspace,
    required TLToDo todo,
  }) = _ToggleTodoTodayWhenever;

  // ステップの並び替えアクション
  const factory TodoAction.reorderSteps({
    required TLWorkspace workspace,
    required TLToDo todo,
    required int oldIndex,
    required int newIndex,
  }) = _ReorderSteps;
}
