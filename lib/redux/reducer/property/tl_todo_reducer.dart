import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class TLToDoReducer {
  // MARK: - Add ToDo
  static List<TLWorkspace> addToDo({
    required List<TLWorkspace> workspaces,
    required TLToDo newToDo,
  }) {
    final corrWorkspaceIdx =
        workspaces.indexWhere((w) => w.id == newToDo.workspaceID);
    if (corrWorkspaceIdx < 0) {
      return workspaces; // Workspaceが見つからない場合は何もしない（到達しない想定）
    }

    final corrWorkspace = workspaces[corrWorkspaceIdx];
    // 該当箇所に追加
    final newCategoryIDToToDosMap = Map<String, TLToDosInTodayAndWhenever>.from(
        corrWorkspace.categoryIDToToDos);
    newCategoryIDToToDosMap[newToDo.categoryID] = newToDo.isInToday
        ? TLToDosInTodayAndWhenever(
            toDosInToday: [
              newToDo,
              ...corrWorkspace
                  .categoryIDToToDos[newToDo.categoryID]!.toDosInToday
            ],
            toDosInWhenever: corrWorkspace
                .categoryIDToToDos[newToDo.categoryID]!.toDosInWhenever,
          )
        : TLToDosInTodayAndWhenever(
            toDosInToday: corrWorkspace
                .categoryIDToToDos[newToDo.categoryID]!.toDosInToday,
            toDosInWhenever: [
              newToDo,
              ...corrWorkspace
                  .categoryIDToToDos[newToDo.categoryID]!.toDosInWhenever
            ],
          );

    final TLWorkspace newWorkspace =
        corrWorkspace.copyWith(categoryIDToToDos: newCategoryIDToToDosMap);
    final List<TLWorkspace> newWorkspaceList = [
      ...workspaces.sublist(0, corrWorkspaceIdx),
      newWorkspace,
      ...workspaces.sublist(corrWorkspaceIdx + 1),
    ];

    return newWorkspaceList;
  }

  // MARK: - Update ToDo
  static List<TLWorkspace> updateToDo({
    required List<TLWorkspace> workspaces,
    required TLToDo newToDo,
  }) {
    final workspaceIdx =
        workspaces.indexWhere((w) => w.id == newToDo.workspaceID);
    if (workspaceIdx < 0) return workspaces; // 該当Workspaceなし

    final workspace = workspaces[workspaceIdx];

    // 更新対象のカテゴリのToDoリストを取得
    final newCategoryIDToToDosMap = Map<String, TLToDosInTodayAndWhenever>.from(
        workspace.categoryIDToToDos);
    final oldToDosInCat = newCategoryIDToToDosMap[newToDo.categoryID];
    if (oldToDosInCat == null) return workspaces; // 該当カテゴリなし

    // 更新対象のToDoのindexを取得
    final isInToday = newToDo.isInToday;
    final updatingList =
        isInToday ? oldToDosInCat.toDosInToday : oldToDosInCat.toDosInWhenever;
    final index = updatingList.indexWhere((t) => t.id == newToDo.id);
    if (index < 0) return workspaces; // 該当ToDoなし

    // ToDoを更新
    final newList = [...updatingList];
    newList[index] = newToDo;

    // カテゴリのToDoリストを更新
    newCategoryIDToToDosMap[newToDo.categoryID] = isInToday
        ? TLToDosInTodayAndWhenever(
            toDosInToday: newList,
            toDosInWhenever: oldToDosInCat.toDosInWhenever,
          )
        : TLToDosInTodayAndWhenever(
            toDosInToday: oldToDosInCat.toDosInToday,
            toDosInWhenever: newList,
          );

    // Workspaceを更新
    final newWorkspace =
        workspace.copyWith(categoryIDToToDos: newCategoryIDToToDosMap);

    // Workspaceリストを更新
    return [
      ...workspaces.sublist(0, workspaceIdx),
      newWorkspace,
      ...workspaces.sublist(workspaceIdx + 1),
    ];
  }

  // MARK: - Remove ToDo
  static List<TLWorkspace> removeToDo({
    required List<TLWorkspace> workspaces,
    required TLToDo corrToDo,
  }) {
    final workspaceIdx =
        workspaces.indexWhere((w) => w.id == corrToDo.workspaceID);
    if (workspaceIdx < 0) return workspaces; // 該当Workspaceなし

    final workspace = workspaces[workspaceIdx];
    final oldToDosInCat = workspace.categoryIDToToDos[corrToDo.categoryID];
    if (oldToDosInCat == null) return workspaces; // 該当カテゴリなし

    final isInToday = corrToDo.isInToday;
    final updatingList =
        isInToday ? oldToDosInCat.toDosInToday : oldToDosInCat.toDosInWhenever;

    // 指定ToDoを除外した新しいリストを作成
    final newList = updatingList.where((t) => t.id != corrToDo.id).toList();
    if (newList.length == updatingList.length) return workspaces; // 該当ToDoなし

    // ToDoリストを更新
    final newCategoryIDToToDosMap = Map<String, TLToDosInTodayAndWhenever>.from(
        workspace.categoryIDToToDos);
    newCategoryIDToToDosMap[corrToDo.categoryID] = isInToday
        ? TLToDosInTodayAndWhenever(
            toDosInToday: newList,
            toDosInWhenever: oldToDosInCat.toDosInWhenever,
          )
        : TLToDosInTodayAndWhenever(
            toDosInToday: oldToDosInCat.toDosInToday,
            toDosInWhenever: newList,
          );

    // Workspaceを更新
    final newWorkspace =
        workspace.copyWith(categoryIDToToDos: newCategoryIDToToDosMap);

    // Workspaceリストを更新
    return [
      ...workspaces.sublist(0, workspaceIdx),
      newWorkspace,
      ...workspaces.sublist(workspaceIdx + 1),
    ];
  }
}
