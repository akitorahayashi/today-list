import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';

class TLToDoCategoryReducer {
  static Future<List<TLWorkspace>> handle(
    List<TLWorkspace> workspaces,
    TLToDoCategoryAction action,
  ) async {
    return action.map(
      addCategory: (a) => _addCategory(
        workspaces: workspaces,
        workspaceID: a.workspaceID,
        categoryToAdd: a.category,
      ),
      updateCategory: (a) => _updateCategory(
        workspaces: workspaces,
        workspaceID: a.workspaceID,
        newCategory: a.newCategory,
      ),
      deleteCategory: (a) => _deleteCategory(
        workspaces: workspaces,
        corrWorkspace: a.corrWorkspace,
        categoryToDelete: a.newCategory,
      ),
    );
  }

  // MARK: - Add Category
  static List<TLWorkspace> _addCategory({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required TLToDoCategory categoryToAdd,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final corrWorkspace = workspaces[idx];
    final copiedBigCategories =
        List<TLToDoCategory>.from(corrWorkspace.bigCategories);
    final copiedSmallCategories =
        Map<String, List<TLToDoCategory>>.from(corrWorkspace.smallCategories);
    final copiedCategoryIDToToDos = {
      ...corrWorkspace.categoryIDToToDos,
      categoryToAdd.id: const TLToDosInTodayAndWhenever(
        toDosInToday: [],
        toDosInWhenever: [],
      ),
    };

    // カテゴリーの追加
    if (categoryToAdd.parentBigCategoryID == null) {
      copiedBigCategories.add(categoryToAdd);
    } else {
      copiedSmallCategories[categoryToAdd.parentBigCategoryID]
          ?.add(categoryToAdd);
    }

    // ToDoを追加するスペースを作成
    if (categoryToAdd.parentBigCategoryID == null) {
      // bigCategoryの場合、対応するsmallCategoryのリストも作成する
      copiedSmallCategories[categoryToAdd.id] = [];
      // 対応するToDoリストを作成
      copiedCategoryIDToToDos[categoryToAdd.id] =
          const TLToDosInTodayAndWhenever(
        toDosInToday: [],
        toDosInWhenever: [],
      );
    } else {
      // smallCategoryの場合のToDoリストを作成
      copiedCategoryIDToToDos[categoryToAdd.id] =
          const TLToDosInTodayAndWhenever(
        toDosInToday: [],
        toDosInWhenever: [],
      );
    }

    final newWorkspace = corrWorkspace.copyWith(
      bigCategories: copiedBigCategories,
      smallCategories: copiedSmallCategories,
      categoryIDToToDos: copiedCategoryIDToToDos,
    );
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Update Category
  static List<TLWorkspace> _updateCategory({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final copiedBigCategories =
        List<TLToDoCategory>.from(oldWorkspace.bigCategories);
    final copiedSmallCategories =
        Map<String, List<TLToDoCategory>>.from(oldWorkspace.smallCategories);

    if (newCategory.parentBigCategoryID == null) {
      final bigCategoryIdx =
          copiedBigCategories.indexWhere((c) => c.id == newCategory.id);
      if (bigCategoryIdx >= 0) {
        copiedBigCategories[bigCategoryIdx] = newCategory;
      }
    } else {
      final smallCategoryList =
          copiedSmallCategories[newCategory.parentBigCategoryID];
      if (smallCategoryList != null) {
        final smallCategoryIdx =
            smallCategoryList.indexWhere((c) => c.id == newCategory.id);
        if (smallCategoryIdx >= 0) {
          smallCategoryList[smallCategoryIdx] = newCategory;
        }
      }
    }

    final newWorkspace = oldWorkspace.copyWith(
      bigCategories: copiedBigCategories,
      smallCategories: copiedSmallCategories,
    );
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Delete Category
  static List<TLWorkspace> _deleteCategory({
    required List<TLWorkspace> workspaces,
    required TLWorkspace corrWorkspace,
    required TLToDoCategory categoryToDelete,
  }) {
    // 以下の一部からカテゴリーを削除する
    final List<TLToDoCategory> copiedBigCategories =
        List<TLToDoCategory>.from(corrWorkspace.bigCategories);
    final Map<String, List<TLToDoCategory>> copiedSmallCategories = {
      for (var entry in corrWorkspace.smallCategories.entries)
        entry.key: List<TLToDoCategory>.from(entry.value),
    };

    // カテゴリーに対応するタスクを削除するため
    final Map<String, TLToDosInTodayAndWhenever> copiedCategoryIDToToDos = {
      for (var entry in corrWorkspace.categoryIDToToDos.entries)
        if (entry.key != categoryToDelete.id) entry.key: entry.value,
    };

    // タスク → カテゴリーの順で削除する
    if (categoryToDelete.parentBigCategoryID != null) {
      // categoryToDeleteがsmallCategoryの時
      // タスクを削除
      copiedCategoryIDToToDos.remove(categoryToDelete.id);
      // カテゴリーを削除
      copiedSmallCategories[categoryToDelete.parentBigCategoryID]?.removeWhere(
          (smallCategory) => smallCategory.id == categoryToDelete.id);
    } else {
      // categoryToDeleteがbigCategoryの時
      // タスクを削除
      copiedCategoryIDToToDos.remove(categoryToDelete.id);
      for (TLToDoCategory smallCategory
          in corrWorkspace.smallCategories[categoryToDelete.id]!) {
        copiedCategoryIDToToDos.remove(smallCategory.id);
      }
      // カテゴリーを削除
      copiedBigCategories
          .removeWhere((bigCategory) => bigCategory.id == categoryToDelete.id);
      copiedSmallCategories.remove(categoryToDelete.id);
    }

    final idx = workspaces.indexWhere((w) => w.id == corrWorkspace.id);
    if (idx < 0) return workspaces;

    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = corrWorkspace.copyWith(
      bigCategories: copiedBigCategories,
      smallCategories: copiedSmallCategories,
      categoryIDToToDos: copiedCategoryIDToToDos,
    );

    return newWorkspaces;
  }
}
