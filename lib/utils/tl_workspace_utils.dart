import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/utils/tl_category_utils.dart';

class TLWorkspaceUtils {
  static void reorderWhenToggle({
    required TLWorkspace workspace,
    required String categoryId,
    required bool ifInToday,
    required int indexOfThisToDoInToDos,
  }) {
    final toDoArrayOfThisToDo =
        workspace.categoryIDToToDos[categoryId]!.getToDos(ifInToday);
    final TLToDo toDoCheckStateHasChanged =
        toDoArrayOfThisToDo.removeAt(indexOfThisToDoInToDos);
    final int indexOfCheckedToDo =
        toDoArrayOfThisToDo.indexWhere((todo) => todo.isChecked);
    if (indexOfCheckedToDo == -1) {
      toDoArrayOfThisToDo.add(toDoCheckStateHasChanged);
    } else {
      toDoArrayOfThisToDo.insert(indexOfCheckedToDo, toDoCheckStateHasChanged);
    }
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
