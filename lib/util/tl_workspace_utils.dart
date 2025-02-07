import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/util/tl_category_utils.dart';

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
    final updatedCategoryIDToToDos =
        Map<String, TLToDosInTodayAndWhenever>.from(
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
