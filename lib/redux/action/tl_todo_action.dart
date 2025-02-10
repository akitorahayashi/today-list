import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo.dart';

part 'generate/tl_todo_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLToDoAction with _$TLToDoAction {
  /// 新規のToDoを追加するアクション
  const factory TLToDoAction.addToDo({
    required String workspaceID, // どのWorkspaceを更新するか
    required String categoryID, // どのカテゴリーに紐付けるか
    required bool ifInToday, // 今日リストかいつでもリストか
    required TLToDo todo, // 追加するToDo本体
  }) = _AddToDo;

  /// 既存のToDoを更新するアクション
  const factory TLToDoAction.updateToDo({
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index, // どのToDo(何番目)を更新するか
    required TLToDo newToDo,
  }) = _UpdateToDo;

  /// 既存のToDoを削除するアクション（必要なら）
  const factory TLToDoAction.removeToDo({
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index,
  }) = _RemoveToDo;

  // 他に、「ToDoを並べ替える」「チェック状態を切り替える」などのアクションを追加してもOK
}
