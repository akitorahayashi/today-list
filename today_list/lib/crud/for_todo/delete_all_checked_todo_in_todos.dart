import '../../model/workspace/workspace.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_todos.dart';

void deleteAllCheckedToDosInThisToDos({
  required bool onlyToday,
  int? selectedWorkspaceIndex,
  TLWorkspace? selectedWorkspace,
  required TLToDos selectedToDos,
}) {
  // effortなどを更新する
  // ToDos.countDeletedToDo(
  //     selectedWorkspaceIndex: selectedWorkspaceIndex,
  //     selectedWorkspace: selectedWorkspace,
  //     numberOfDeletedToDo: selectedToDos.countCheckedToDosAndStepsInThisToDos(
  //         selectedToDos: selectedToDos));
  // チェックされているtodoを消す
  selectedToDos.toDosInToday.removeWhere((todo) => todo.isChecked);
  if (!onlyToday) {
    selectedToDos.toDosInWhenever.removeWhere((todo) => todo.isChecked);
  }
  // 残っているものでstepがチェックされているものを消す
  for (TLToDo todo in selectedToDos.toDosInToday) {
    todo.steps.removeWhere((step) => step.isChecked);
  }
  for (TLToDo todo in selectedToDos.toDosInWhenever) {
    todo.steps.removeWhere((step) => step.isChecked);
  }
  // ここでセーブとかvibrateしたら複数になることがある
}
