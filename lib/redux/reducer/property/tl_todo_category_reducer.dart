import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_category_action.dart';

class TLCategoryReducer {
  static Future<List<TLWorkspace>> handle(
    List<TLWorkspace> workspaces,
    TLCategoryAction action,
    String currentWorkspaceID,
  ) async {
    return action.map(
      addCategory: (a) => addCategory(
        workspaces: workspaces,
        workspaceID: a.workspaceID,
        category: a.category,
      ),
      updateCategory: (a) => updateCategory(
        workspaces: workspaces,
        workspaceID: a.workspaceID,
        newCategory: a.newCategory,
      ),
      removeCategory: (a) => removeCategory(
        workspaces: workspaces,
        workspaceID: a.workspaceID,
        corrCategory: a.newCategory,
      ),
    );
  }

  // MARK: - Add Category
  static List<TLWorkspace> addCategory({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required TLToDoCategory category,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final newBigCategories =
        List<TLToDoCategory>.from(oldWorkspace.bigCategories);
    final copiedSmallCategories =
        Map<String, List<TLToDoCategory>>.from(oldWorkspace.smallCategories);

    if (category.parentBigCategoryID == null) {
      newBigCategories.add(category);
    } else {
      copiedSmallCategories[category.parentBigCategoryID]?.add(category);
    }

    final newWorkspace = oldWorkspace.copyWith(
      bigCategories: newBigCategories,
      smallCategories: copiedSmallCategories,
    );
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Update Category
  static List<TLWorkspace> updateCategory({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final newBigCategories =
        List<TLToDoCategory>.from(oldWorkspace.bigCategories);
    final newSmallCategories =
        Map<String, List<TLToDoCategory>>.from(oldWorkspace.smallCategories);

    if (newCategory.parentBigCategoryID == null) {
      final bigCategoryIdx =
          newBigCategories.indexWhere((c) => c.id == newCategory.id);
      if (bigCategoryIdx >= 0) {
        newBigCategories[bigCategoryIdx] = newCategory;
      }
    } else {
      final smallCategoryList =
          newSmallCategories[newCategory.parentBigCategoryID];
      if (smallCategoryList != null) {
        final smallCategoryIdx =
            smallCategoryList.indexWhere((c) => c.id == newCategory.id);
        if (smallCategoryIdx >= 0) {
          smallCategoryList[smallCategoryIdx] = newCategory;
        }
      }
    }

    final newWorkspace = oldWorkspace.copyWith(
      bigCategories: newBigCategories,
      smallCategories: newSmallCategories,
    );
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Remove Category
  static List<TLWorkspace> removeCategory({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required TLToDoCategory corrCategory,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final newBigCategories =
        List<TLToDoCategory>.from(oldWorkspace.bigCategories);
    final newSmallCategories =
        Map<String, List<TLToDoCategory>>.from(oldWorkspace.smallCategories);

    final bigCategoryIdx =
        newBigCategories.indexWhere((c) => c.id == corrCategory.id);
    if (bigCategoryIdx >= 0) {
      newBigCategories.removeAt(bigCategoryIdx);
    } else {
      newSmallCategories.forEach((parentID, categories) {
        categories.removeWhere((c) => c.id == corrCategory.id);
      });
    }

    final newWorkspace = oldWorkspace.copyWith(
      bigCategories: newBigCategories,
      smallCategories: newSmallCategories,
    );
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }
}
