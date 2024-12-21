import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/utils/tl_category_utils.dart';

class TLWorkspaceUtils {
  static TLWorkspace reorderWhenToggle({
    required TLWorkspace corrWorkspace,
    required String categoryId,
    required bool ifInToday,
    required int indexOfThisToDoInToDos,
  }) {
    // 元のリストをコピーして変更可能にする
    final toDoArrayOfThisToDo = List<TLToDo>.from(
      corrWorkspace.categoryIDToToDos[categoryId]!.getToDos(ifInToday),
    );

    // 対象のToDoを取り出す
    final TLToDo toDoCheckStateHasChanged =
        toDoArrayOfThisToDo.removeAt(indexOfThisToDoInToDos);

    // チェック済みのToDoの位置を取得
    final int indexOfCheckedToDo =
        toDoArrayOfThisToDo.indexWhere((todo) => todo.isChecked);

    // チェック済みの位置に挿入または末尾に追加
    if (indexOfCheckedToDo == -1) {
      toDoArrayOfThisToDo.add(toDoCheckStateHasChanged);
    } else {
      toDoArrayOfThisToDo.insert(indexOfCheckedToDo, toDoCheckStateHasChanged);
    }

    // 更新後のToDosを生成
    final updatedCategoryIDToToDos = Map<String, TLToDos>.from(
      corrWorkspace.categoryIDToToDos,
    );
    updatedCategoryIDToToDos[categoryId] = corrWorkspace
        .categoryIDToToDos[categoryId]!
        .copyWith(toDosInToday: ifInToday ? toDoArrayOfThisToDo : []);

    // 新しいWorkspaceを返す
    return corrWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );
  }

  static int getNumOfToDo(TLWorkspace workspace, {required bool ifInToday}) {
    int todoCount = 0;
    for (TLCategory bigCategory in workspace.bigCategories) {
      todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
        ifInToday: ifInToday,
        corrToDos: workspace.categoryIDToToDos[bigCategory.id]!,
      );
      for (TLCategory smallCategory
          in workspace.smallCategories[bigCategory.id]!) {
        todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
          ifInToday: ifInToday,
          corrToDos: workspace.categoryIDToToDos[smallCategory.id]!,
        );
      }
    }
    return todoCount;
  }

  static Future<void> deleteCheckedToDosInTodayInAWorkspace(
      TLWorkspace workspace,
      {required bool onlyToday}) async {
    for (TLCategory bigCategory in workspace.bigCategories) {
      deleteAllCheckedToDosInAToDos(
        onlyToday: onlyToday,
        selectedToDos: workspace.categoryIDToToDos[bigCategory.id]!,
      );
      for (TLCategory smallCategory
          in workspace.smallCategories[bigCategory.id]!) {
        deleteAllCheckedToDosInAToDos(
          onlyToday: onlyToday,
          selectedToDos: workspace.categoryIDToToDos[smallCategory.id]!,
        );
      }
    }
  }

  static void deleteAllCheckedToDosInAToDos({
    required bool onlyToday,
    required TLToDos selectedToDos,
  }) {
    selectedToDos.toDosInToday.removeWhere((todo) => todo.isChecked);
    for (TLToDo todo in selectedToDos.toDosInToday) {
      todo.steps.removeWhere((step) => step.isChecked);
    }
    if (!onlyToday) {
      selectedToDos.toDosInWhenever.removeWhere((todo) => todo.isChecked);
      for (TLToDo todo in selectedToDos.toDosInWhenever) {
        todo.steps.removeWhere((step) => step.isChecked);
      }
    }
  }
}
