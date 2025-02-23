import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class TLWorkspaceUtils {
  static int getNumOfToDoInWorkspace(TLWorkspace workspace,
      {required bool ifInToday}) {
    int todoCount = 0;
    for (TLToDoCategory bigCategory in workspace.bigCategories) {
      todoCount += bigCategory.getNumberOfToDosInThisCategory(
          ifInToday: ifInToday,
          corrToDos: workspace.categoryIDToToDos[bigCategory.id]!);
      for (TLToDoCategory smallCategory
          in workspace.smallCategories[bigCategory.id]!) {
        todoCount += smallCategory.getNumberOfToDosInThisCategory(
            ifInToday: ifInToday,
            corrToDos: workspace.categoryIDToToDos[smallCategory.id]!);
      }
    }
    return todoCount;
  }

  static TLToDosInTodayAndWhenever deleteAllCheckedToDosInAToDos({
    required bool onlyToday,
    required TLToDosInTodayAndWhenever selectedToDos,
  }) {
    // `toDosInToday` の新しいリストを生成
    final updatedToDosInToday = selectedToDos.toDosInToday
        .where((todo) => !todo.isChecked) // チェックされたものを除外
        .map((todo) => todo.copyWith(
              steps: todo.steps.where((step) => !step.isChecked).toList(),
            ))
        .toList();

    // `toDosInWhenever` の新しいリストを生成
    final updatedToDosInWhenever = onlyToday
        ? selectedToDos.toDosInWhenever // 変更なし
        : selectedToDos.toDosInWhenever
            .where((todo) => !todo.isChecked) // チェックされたものを除外
            .map((todo) => todo.copyWith(
                  steps: todo.steps.where((step) => !step.isChecked).toList(),
                ))
            .toList();

    // 新しいインスタンスを返す
    return selectedToDos.copyWith(
      toDosInToday: updatedToDosInToday,
      toDosInWhenever: updatedToDosInWhenever,
    );
  }
}
