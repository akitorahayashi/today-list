import 'package:flutter/material.dart';
import '../../model/workspace/workspace.dart';
import '../../model/tl_category.dart';
import 'delete_all_checked_todo_in_todos.dart';

// このworkspaceの今日でチェック済みtodoを全て削除するための関数
void deleteCheckedToDosInToday({
  required BuildContext context,
  required int selectedWorkspaceIndex,
  required String selectedWorkspaceCategoryId,
  required Workspace selectedWorkspace,
}) {
  for (TLCategory bigCategory in (selectedWorkspace).bigCategories) {
    // bigCategoryに関するcheckのsort
    deleteAllCheckedToDosInThisToDos(
      onlyToday: true,
      selectedWorkspaceIndex: selectedWorkspaceIndex,
      selectedWorkspace: selectedWorkspace,
      selectedToDos: (selectedWorkspace).toDos[bigCategory.id]!,
    );
    for (TLCategory smallCategory
        in (selectedWorkspace).smallCategories[bigCategory.id]!) {
      // smallCategoryに関するcheckのsort
      deleteAllCheckedToDosInThisToDos(
          onlyToday: true,
          selectedWorkspaceIndex: selectedWorkspaceIndex,
          selectedWorkspace: selectedWorkspace,
          selectedToDos: selectedWorkspace.toDos[smallCategory.id]!);
    }
  }
}
