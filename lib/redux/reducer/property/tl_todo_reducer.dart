import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class TLToDoReducer {
  // MARK: - Add ToDo
  static List<TLWorkspace> addToDo({
    required List<TLWorkspace> workspaces,
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) {
    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: newToDo.categoryID,
      updateFn: (oldListOfToDo) => [newToDo, ...oldListOfToDo],
      isInToday: newToDo.isInToday,
    );
  }

  // MARK: - Update ToDo
  static List<TLWorkspace> updateToDo({
    required List<TLWorkspace> workspaces,
    required TLWorkspace corrWorkspace,
    required TLToDo newToDo,
  }) {
    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: newToDo.categoryID,
      updateFn: (oldListOfToDo) =>
          oldListOfToDo.map((t) => t.id == newToDo.id ? newToDo : t).toList(),
      isInToday: newToDo.isInToday,
    );
  }

  // MARK: - Remove ToDo
  static List<TLWorkspace> removeToDo({
    required List<TLWorkspace> workspaces,
    required TLWorkspace corrWorkspace,
    required TLToDo corrToDo,
  }) {
    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: corrToDo.categoryID,
      updateFn: (oldListOfToDo) =>
          oldListOfToDo.where((t) => t.id != corrToDo.id).toList(),
      isInToday: corrToDo.isInToday,
    );
  }

  // MARK: - 共通処理: ToDo リストの更新
  static List<TLWorkspace> _updateWorkspaceList({
    required List<TLWorkspace> workspaces,
    required TLWorkspace corrWorkspace,
    required String categoryID,
    required List<TLToDo> Function(List<TLToDo>) updateFn,
    required bool isInToday,
  }) {
    final targetTodos = corrWorkspace.categoryIDToToDos[categoryID];
    if (targetTodos == null) return workspaces;

    final updatedToDos = updateFn(targetTodos.getToDos(isInToday));
    if (updatedToDos.length == targetTodos.getToDos(isInToday).length &&
        updatedToDos
            .every((t) => targetTodos.getToDos(isInToday).contains(t))) {
      return workspaces;
    }

    final updatedCategoryIDToToDos = {
      ...corrWorkspace.categoryIDToToDos,
      categoryID: targetTodos.updateListOfToDoInTodayOrWhenever(
        isInToday: isInToday,
        updatedToDos: updatedToDos,
      ),
    };

    return workspaces.map((ws) {
      return ws == corrWorkspace
          ? ws.copyWith(categoryIDToToDos: updatedCategoryIDToToDos)
          : ws;
    }).toList();
  }
}
