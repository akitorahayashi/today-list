import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLToDoAction with _$TLToDoAction {
  // 新規のToDoを追加する
  const factory TLToDoAction.addToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) = _AddToDo;

  // 指定したToDoを更新する
  const factory TLToDoAction.updateToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) = _UpdateToDo;

  // 該当するToDoを削除する
  const factory TLToDoAction.deleteToDo({
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
  }) = _RemoveToDo;
}
