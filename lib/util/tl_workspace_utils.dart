import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/util/tl_category_utils.dart';

class TLWorkspaceUtils {
  static List<TLToDo> reorderWhenToggle({
    required List<TLToDo> toDoArrayOfThisToDo,
    required int indexOfThisToDoInToDos,
  }) {
    // 対象のToDoを取得
    final TLToDo toDoCheckStateHasChanged =
        toDoArrayOfThisToDo[indexOfThisToDoInToDos];

    // チェック済みと未チェックのToDoを分類（取得したToDoを除外）
    final List<TLToDo> uncheckedToDos = toDoArrayOfThisToDo
        .where((todo) => !todo.isChecked && todo != toDoCheckStateHasChanged)
        .toList();
    final List<TLToDo> checkedToDos = toDoArrayOfThisToDo
        .where((todo) => todo.isChecked && todo != toDoCheckStateHasChanged)
        .toList();

    // 新しいリストを作成（変更後のToDoを適切な位置に挿入）
    return [...uncheckedToDos, toDoCheckStateHasChanged, ...checkedToDos];
  }

  static int getNumOfToDo(TLWorkspace workspace, {required bool ifInToday}) {
    int todoCount = 0;
    for (TLToDoCategory bigCategory in workspace.bigCategories) {
      todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
        ifInToday: ifInToday,
        corrToDos: workspace.categoryIDToToDos[bigCategory.id]!,
      );
      for (TLToDoCategory smallCategory
          in workspace.smallCategories[bigCategory.id]!) {
        todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
          ifInToday: ifInToday,
          corrToDos: workspace.categoryIDToToDos[smallCategory.id]!,
        );
      }
    }
    return todoCount;
  }

  static Future<TLWorkspace> deleteCheckedToDosInTodayInAWorkspace(
    TLWorkspace corrWorkspace, {
    required bool onlyToday,
  }) async {
    // `categoryIDToToDos` を再構築する
    final updatedCategoryIDToToDos = corrWorkspace.categoryIDToToDos.map(
      (categoryId, todos) {
        return MapEntry(
          categoryId,
          deleteAllCheckedToDosInAToDos(
            onlyToday: onlyToday,
            selectedToDos: todos,
          ),
        );
      },
    );

    // 新しいインスタンスを返す
    return corrWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );
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
