import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class TLToDoReducer {
  // MARK: - Add ToDo
  static List<TLWorkspace> addToDo({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required TLToDo todo,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces; // Workspaceが見つからない場合は何もしない

    final oldWorkspace = workspaces[idx];

    // 対象カテゴリーのToDosを取得
    final oldToDosInCat = oldWorkspace.categoryIDToToDos[categoryID];
    if (oldToDosInCat == null) return workspaces; // 存在しない場合は何もしない

    // ToDoリストを更新
    final updatingList =
        ifInToday ? oldToDosInCat.toDosInToday : oldToDosInCat.toDosInWhenever;
    final newList = [todo, ...updatingList]; // 先頭に追加

    final newToDosInCat = oldToDosInCat.copyWith(
      toDosInToday: ifInToday ? newList : oldToDosInCat.toDosInToday,
      toDosInWhenever: ifInToday ? oldToDosInCat.toDosInWhenever : newList,
    );

    // Workspaceを更新
    final newCategoryMap = Map<String, TLToDosInTodayAndWhenever>.from(
        oldWorkspace.categoryIDToToDos);
    newCategoryMap[categoryID] = newToDosInCat;

    final newWorkspace =
        oldWorkspace.copyWith(categoryIDToToDos: newCategoryMap);
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Update ToDo
  static List<TLWorkspace> updateToDo({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index,
    required TLToDo newToDo,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final oldToDosInCat = oldWorkspace.categoryIDToToDos[categoryID];
    if (oldToDosInCat == null) return workspaces;

    final updatingList =
        ifInToday ? oldToDosInCat.toDosInToday : oldToDosInCat.toDosInWhenever;
    if (index < 0 || index >= updatingList.length)
      return workspaces; // 不正な index

    // ToDoを更新
    final newList = [...updatingList];
    newList[index] = newToDo;

    final newToDosInCat = oldToDosInCat.copyWith(
      toDosInToday: ifInToday ? newList : oldToDosInCat.toDosInToday,
      toDosInWhenever: ifInToday ? oldToDosInCat.toDosInWhenever : newList,
    );

    final newCategoryMap = Map<String, TLToDosInTodayAndWhenever>.from(
        oldWorkspace.categoryIDToToDos);
    newCategoryMap[categoryID] = newToDosInCat;

    final newWorkspace =
        oldWorkspace.copyWith(categoryIDToToDos: newCategoryMap);
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }

  // MARK: - Remove ToDo
  static List<TLWorkspace> removeToDo({
    required List<TLWorkspace> workspaces,
    required String workspaceID,
    required String categoryID,
    required bool ifInToday,
    required int index,
  }) {
    final idx = workspaces.indexWhere((w) => w.id == workspaceID);
    if (idx < 0) return workspaces;

    final oldWorkspace = workspaces[idx];
    final oldToDosInCat = oldWorkspace.categoryIDToToDos[categoryID];
    if (oldToDosInCat == null) return workspaces;

    final updatingList =
        ifInToday ? oldToDosInCat.toDosInToday : oldToDosInCat.toDosInWhenever;
    if (index < 0 || index >= updatingList.length) return workspaces;

    // 指定indexのToDoを削除
    final newList = [...updatingList]..removeAt(index);

    final newToDosInCat = oldToDosInCat.copyWith(
      toDosInToday: ifInToday ? newList : oldToDosInCat.toDosInToday,
      toDosInWhenever: ifInToday ? oldToDosInCat.toDosInWhenever : newList,
    );

    final newCategoryMap = Map<String, TLToDosInTodayAndWhenever>.from(
        oldWorkspace.categoryIDToToDos);
    newCategoryMap[categoryID] = newToDosInCat;

    final newWorkspace =
        oldWorkspace.copyWith(categoryIDToToDos: newCategoryMap);
    final newWorkspaces = [...workspaces];
    newWorkspaces[idx] = newWorkspace;

    return newWorkspaces;
  }
}
