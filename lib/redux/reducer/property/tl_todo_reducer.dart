import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';

class TLToDoReducer {
  static List<TLWorkspace> reduce(
      List<TLWorkspace> workspaces, TLToDoAction action) {
    final updatedWorkspaces = action.map(
      addToDo: (a) => TLToDoReducer._addToDo(
        workspaces: workspaces,
        corrWorkspace: a.corrWorkspace,
        newToDo: a.newToDo,
      ),
      updateToDo: (a) => TLToDoReducer._updateToDo(
        workspaces: workspaces,
        corrWorkspace: a.corrWorkspace,
        newToDo: a.newToDo,
      ),
      deleteToDo: (a) => TLToDoReducer._removeToDo(
        workspaces: workspaces,
        corrWorkspace: a.corrWorkspace,
        corrToDo: a.corrToDo,
      ),
      toggleToDoCheckStatus: (a) => _toggleToDoCheckStatus(
        workspaces,
        a.corrWorkspace,
        a.corrToDo,
      ),
      toggleToDoTodayWhenever: (a) =>
          _toggleToDoTodayWhenever(workspaces, a.corrWorkspace, a.corrToDo),
      reorderToDo: (a) => _reorderToDo(
        workspaces,
        a.corrWorkspace,
        a.categoryID,
        a.ifInToday,
        a.oldIndex,
        a.newIndex,
      ),
      toggleStepCheckStatus: (a) => _toggleStepCheckStatus(
        workspaces,
        a.corrWorkspace,
        a.corrToDo,
        a.corrStep,
      ),
      reorderSteps: (a) => _reorderSteps(
        workspaces,
        a.corrWorkspace,
        a.corrToDo,
        a.oldIndex,
        a.newIndex,
      ),
    );
    return updatedWorkspaces;
  }

  // MARK: - Add ToDo
  static List<TLWorkspace> _addToDo({
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
  static List<TLWorkspace> _updateToDo({
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
  static List<TLWorkspace> _removeToDo({
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

  // MARK: - Toggle ToDo Check Status
  static List<TLWorkspace> _toggleToDoCheckStatus(
    List<TLWorkspace> workspaces,
    TLWorkspace corrWorkspace,
    TLToDo corrToDo,
  ) {
    final newCheckedState = !corrToDo.isChecked;
    final updatedSteps = corrToDo.steps
        .map((step) => step.copyWith(isChecked: newCheckedState))
        .toList();

    // 新しい状態のToDoを作成
    final copiedToDo = corrToDo.copyWith(
      isChecked: newCheckedState,
      steps: updatedSteps,
    );

    final List<TLToDo> toDoArrayOfThisToDo = corrWorkspace
        .categoryIDToToDos[corrToDo.categoryID]!
        .getToDos(corrToDo.isInToday);

    // チェック済みと未チェックのToDoを分類（状態を変更したToDoを除外）
    final List<TLToDo> uncheckedToDos = toDoArrayOfThisToDo
        .where((todo) => !todo.isChecked && todo.id != copiedToDo.id)
        .toList();
    final List<TLToDo> checkedToDos = toDoArrayOfThisToDo
        .where((todo) => todo.isChecked && todo.id != copiedToDo.id)
        .toList();

    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: corrToDo.categoryID,
      updateFn: (oldList) => [...uncheckedToDos, copiedToDo, ...checkedToDos],
      isInToday: corrToDo.isInToday,
    );
  }

  // MARK: - Toggle ToDo Between Today and Whenever
  static List<TLWorkspace> _toggleToDoTodayWhenever(
    List<TLWorkspace> workspaces,
    TLWorkspace corrWorkspace,
    TLToDo corrToDo,
  ) {
    final bool isMovingToToday = !corrToDo.isInToday; // Determine target list
    final updatedToDo = corrToDo.copyWith(isInToday: isMovingToToday);
    final toDosInCategory =
        corrWorkspace.categoryIDToToDos[corrToDo.categoryID]!;

    // Extract current lists
    final List<TLToDo> fromList = toDosInCategory.getToDos(!isMovingToToday);
    final List<TLToDo> toList = toDosInCategory.getToDos(isMovingToToday);

    // Remove from current list & add to the new list
    final List<TLToDo> updatedFromList =
        fromList.where((todo) => todo.id != updatedToDo.id).toList();
    final List<TLToDo> updatedToList = [updatedToDo, ...toList];

    // Update category's ToDo lists
    final updatedToDosInCategory = toDosInCategory.copyWith(
      toDosInToday: isMovingToToday ? updatedToList : updatedFromList,
      toDosInWhenever: isMovingToToday ? updatedFromList : updatedToList,
    );

    // Update workspaces
    return workspaces.map((ws) {
      return ws.id == corrWorkspace.id
          ? ws.copyWith(categoryIDToToDos: {
              ...corrWorkspace.categoryIDToToDos,
              corrToDo.categoryID: updatedToDosInCategory,
            })
          : ws;
    }).toList();
  }

  // MARK: - Reorder ToDo
  static List<TLWorkspace> _reorderToDo(
    List<TLWorkspace> workspaces,
    TLWorkspace corrWorkspace,
    String categoryID,
    bool ifInToday,
    int oldIndex,
    int newIndex,
  ) {
    if (oldIndex == newIndex) return workspaces;

    final toDosInCategory = corrWorkspace.categoryIDToToDos[categoryID]!;
    final toDoList = List<TLToDo>.from(toDosInCategory.getToDos(ifInToday));

    final int indexOfCheckedToDo =
        toDoList.indexWhere((todo) => todo.isChecked);

    if (indexOfCheckedToDo == -1 || newIndex < indexOfCheckedToDo) {
      final movedToDo = toDoList.removeAt(oldIndex);
      toDoList.insert(newIndex, movedToDo);

      final updatedToDosInCategory = toDosInCategory.copyWith(
        toDosInToday: ifInToday ? toDoList : toDosInCategory.toDosInToday,
        toDosInWhenever: ifInToday ? toDosInCategory.toDosInWhenever : toDoList,
      );

      return workspaces.map((ws) {
        return ws.id == corrWorkspace.id
            ? ws.copyWith(categoryIDToToDos: {
                ...corrWorkspace.categoryIDToToDos,
                categoryID: updatedToDosInCategory,
              })
            : ws;
      }).toList();
    }

    return workspaces;
  }

  // MARK: - Toggle Step Check Status
  static List<TLWorkspace> _toggleStepCheckStatus(
    List<TLWorkspace> workspaces,
    TLWorkspace corrWorkspace,
    TLToDo corrToDo,
    TLStep corrStep,
  ) {
    final updatedSteps = corrToDo.steps
        .map((step) => step.id == corrStep.id
            ? step.copyWith(isChecked: !step.isChecked)
            : step)
        .toList();

    // ToDoのチェック状態を更新（すべてのステップがチェック済みならToDoもチェック済みにする）
    final updatedToDo = corrToDo.copyWith(
      steps: updatedSteps,
      isChecked: updatedSteps.every((step) => step.isChecked),
    );

    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: corrToDo.categoryID,
      updateFn: (oldListOfToDo) => oldListOfToDo
          .map((t) => t.id == updatedToDo.id ? updatedToDo : t)
          .toList(),
      isInToday: corrToDo.isInToday,
    );
  }

  // MARK: - Reorder Steps
  static List<TLWorkspace> _reorderSteps(
    List<TLWorkspace> workspaces,
    TLWorkspace corrWorkspace,
    TLToDo corrToDo,
    int oldIndex,
    int newIndex,
  ) {
    if (oldIndex == newIndex) return workspaces;

    final reorderedSteps = List<TLStep>.from(corrToDo.steps);
    final step = reorderedSteps.removeAt(oldIndex);
    reorderedSteps.insert(newIndex, step);

    final updatedToDo = corrToDo.copyWith(steps: reorderedSteps);
    return _updateWorkspaceList(
      workspaces: workspaces,
      corrWorkspace: corrWorkspace,
      categoryID: corrToDo.categoryID,
      updateFn: (oldListOfToDo) => oldListOfToDo
          .map((t) => t.id == updatedToDo.id ? updatedToDo : t)
          .toList(),
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
