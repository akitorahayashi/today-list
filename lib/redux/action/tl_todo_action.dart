import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo.dart';

part 'generate/tl_todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLToDoAction with _$TLToDoAction {
  // 新規のToDoを追加する
  const factory TLToDoAction.addToDo({
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required TLToDo todo,
  }) = _AddToDo;

  // 既存のToDoを更新する
  const factory TLToDoAction.updateToDo({
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index,
    required TLToDo newToDo,
  }) = _UpdateToDo;

  // 既存のToDoを削除する
  const factory TLToDoAction.removeToDo({
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index,
  }) = _RemoveToDo;
}
