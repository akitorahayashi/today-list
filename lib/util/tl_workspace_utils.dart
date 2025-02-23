import 'package:today_list/model/todo/tl_todo_category.dart';
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
}
