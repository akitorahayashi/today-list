import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/flux/store/workspace_store.dart';

/// ToDoの状態を管理するプロバイダー
/// AsyncValueを返すことで、読み込み中、エラー、データの状態を管理できる
final todoProvider = AsyncNotifierProvider<TodoNotifier, List<TLWorkspace>>(() {
  return TodoNotifier();
});

/// ToDoの状態を管理するNotifier
class TodoNotifier extends AsyncNotifier<List<TLWorkspace>> {
  @override
  Future<List<TLWorkspace>> build() async {
    // workspacesProviderを監視し、その値を返す
    final workspaces = await ref.watch(workspacesProvider.future);
    return workspaces;
  }

  /// ToDoを追加する
  Future<void> addTodo(TLWorkspace workspace, TLToDo todo) async {
    // 現在の状態を保持
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      // 最新のワークスペース一覧を取得
      final workspacesAsync = await ref.read(workspacesProvider.future);

      // 対象のワークスペースを見つける
      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // ワークスペースのToDoリストを更新
        final updatedWorkspace = _updateWorkspaceTodos(
          workspacesAsync[index],
          todo,
          null,
          false,
        );

        // ワークスペース一覧を更新
        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        // workspacesProviderを更新
        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        // 状態を更新
        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ToDoを更新する
  Future<void> updateTodo(TLWorkspace workspace, TLToDo todo) async {
    // 現在の状態を保持
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        final updatedWorkspace = _updateWorkspaceTodos(
          workspacesAsync[index],
          todo,
          null,
          true,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        // 状態を更新
        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ToDoを削除する
  Future<void> deleteTodo(
    TLWorkspace workspace,
    TLToDo todo,
    bool ifInToday,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        final updatedWorkspace = _deleteWorkspaceTodo(
          workspacesAsync[index],
          todo,
          ifInToday,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ToDoのチェック状態を切り替える
  Future<void> toggleTodoCheck(
    TLWorkspace workspace,
    TLToDo todo,
    bool ifInToday,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // チェック状態を反転したToDoを作成
        final newCheckedState = !todo.isChecked;

        // ToDoがチェックされた場合、すべてのステップもチェックする
        final updatedSteps =
            todo.steps.map((step) {
              // Todo がチェックされるとき、すべてのステップもチェックする
              if (newCheckedState) {
                return step.copyWith(isChecked: true);
              }
              return step;
            }).toList();

        // 更新されたToDoを作成
        final updatedTodo = todo.copyWith(
          isChecked: newCheckedState,
          steps: updatedSteps,
        );

        // 該当のToDoリストを取得
        final todosInTodayAndWhenever =
            workspacesAsync[index].workspaceIDToToDos[workspace.id]!;
        final todosList =
            ifInToday
                ? List<TLToDo>.from(todosInTodayAndWhenever.toDosInToday)
                : List<TLToDo>.from(todosInTodayAndWhenever.toDosInWhenever);

        // 元の位置からToDoを削除
        final todoIndex = todosList.indexWhere((t) => t.id == todo.id);
        if (todoIndex >= 0) {
          todosList.removeAt(todoIndex);
        }

        // チェック状態に応じて適切な位置に挿入
        if (newCheckedState) {
          // チェックされた場合、リストの最後に追加
          todosList.add(updatedTodo);
        } else {
          // チェックが外れた場合、最初のチェック済みToDoの直前に挿入
          final firstCheckedIndex = todosList.indexWhere((t) => t.isChecked);
          if (firstCheckedIndex >= 0) {
            // チェック済みのToDoが存在する場合、その直前に挿入
            todosList.insert(firstCheckedIndex, updatedTodo);
          } else {
            // チェック済みのToDoが存在しない場合、リストの最後に追加
            todosList.add(updatedTodo);
          }
        }

        // 更新されたToDoリストでワークスペースを更新
        final updatedWorkspace = _reorderWorkspaceTodos(
          workspacesAsync[index],
          todosList,
          ifInToday,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ToDoを今日といつかの間で切り替える
  Future<void> toggleTodoTodayWhenever(
    TLWorkspace workspace,
    TLToDo todo,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // 今日/いつかの状態を反転したToDoを作成
        final updatedTodo = todo.copyWith(isInToday: !todo.isInToday);

        // 元のリストからToDoを削除
        final updatedWorkspace1 = _deleteWorkspaceTodo(
          workspacesAsync[index],
          todo,
          todo.isInToday,
        );

        // 新しいリストにToDoを追加
        final updatedWorkspace2 = _updateWorkspaceTodos(
          updatedWorkspace1,
          updatedTodo,
          null,
          false,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace2;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ステップを並べ替える
  Future<void> reorderSteps(
    TLWorkspace workspace,
    TLToDo todo,
    int oldIndex,
    int newIndex,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // ステップリストを並べ替え
        final steps = List<TLStep>.from(todo.steps);
        final item = steps.removeAt(oldIndex);
        steps.insert(newIndex, item);

        // 更新されたステップリストを持つToDoを作成
        final updatedTodo = todo.copyWith(steps: steps);

        // ワークスペースのToDoリストを更新
        final updatedWorkspace = _updateWorkspaceTodos(
          workspacesAsync[index],
          updatedTodo,
          null,
          true,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ToDoを並べ替える
  Future<void> reorderTodos(
    TLWorkspace workspace,
    List<TLToDo> todos,
    int oldIndex,
    int newIndex,
    String category,
    bool ifInToday,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // ToDoリストを並べ替え
        final reorderedTodos = List<TLToDo>.from(todos);
        final item = reorderedTodos.removeAt(oldIndex);
        reorderedTodos.insert(newIndex, item);

        // ワークスペースのToDoリストを更新
        final updatedWorkspace = _reorderWorkspaceTodos(
          workspacesAsync[index],
          reorderedTodos,
          ifInToday,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // ワークスペースのToDoリストを更新するヘルパーメソッド
  TLWorkspace _updateWorkspaceTodos(
    TLWorkspace workspace,
    TLToDo todo,
    List<TLStep>? steps,
    bool isUpdate,
  ) {
    final workspaceIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
      workspace.workspaceIDToToDos,
    );
    final todosInTodayAndWhenever = workspaceIDToToDos[workspace.id]!;

    // 更新または追加するToDoを準備
    final updatedTodo = steps != null ? todo.copyWith(steps: steps) : todo;

    // 今日のToDoリストまたはいつかのToDoリストを更新
    if (todo.isInToday) {
      final todosInToday = List<TLToDo>.from(
        todosInTodayAndWhenever.toDosInToday,
      );

      if (isUpdate) {
        final index = todosInToday.indexWhere((t) => t.id == todo.id);
        if (index >= 0) {
          todosInToday[index] = updatedTodo;
        }
      } else {
        todosInToday.add(updatedTodo);
      }

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInToday: todosInToday,
      );
    } else {
      final todosInWhenever = List<TLToDo>.from(
        todosInTodayAndWhenever.toDosInWhenever,
      );

      if (isUpdate) {
        final index = todosInWhenever.indexWhere((t) => t.id == todo.id);
        if (index >= 0) {
          todosInWhenever[index] = updatedTodo;
        }
      } else {
        todosInWhenever.add(updatedTodo);
      }

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInWhenever: todosInWhenever,
      );
    }

    return workspace.copyWith(workspaceIDToToDos: workspaceIDToToDos);
  }

  // ワークスペースからToDoを削除するヘルパーメソッド
  TLWorkspace _deleteWorkspaceTodo(
    TLWorkspace workspace,
    TLToDo todo,
    bool ifInToday,
  ) {
    final workspaceIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
      workspace.workspaceIDToToDos,
    );
    final todosInTodayAndWhenever = workspaceIDToToDos[workspace.id]!;

    if (ifInToday) {
      final todosInToday =
          todosInTodayAndWhenever.toDosInToday
              .where((t) => t.id != todo.id)
              .toList();

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInToday: todosInToday,
      );
    } else {
      final todosInWhenever =
          todosInTodayAndWhenever.toDosInWhenever
              .where((t) => t.id != todo.id)
              .toList();

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInWhenever: todosInWhenever,
      );
    }

    return workspace.copyWith(workspaceIDToToDos: workspaceIDToToDos);
  }

  /// チェック済みのToDoをすべて削除する
  Future<void> deleteAllCheckedTodos(
    TLWorkspace workspace,
    bool ifInToday,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        final updatedWorkspace = _deleteAllCheckedTodos(
          workspacesAsync[index],
          ifInToday,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  /// ステップのチェック状態を切り替える
  Future<void> toggleStepCheck(
    TLWorkspace workspace,
    TLToDo todo,
    TLStep step,
  ) async {
    state = const AsyncValue<List<TLWorkspace>>.loading().copyWithPrevious(
      state,
    );

    try {
      final workspacesAsync = await ref.read(workspacesProvider.future);

      final index = workspacesAsync.indexWhere((w) => w.id == workspace.id);
      if (index >= 0) {
        // ステップのチェック状態を反転
        final newStepCheckedState = !step.isChecked;
        final updatedSteps =
            todo.steps.map((s) {
              if (s.id == step.id) {
                return s.copyWith(isChecked: newStepCheckedState);
              }
              return s;
            }).toList();

        // 全てのステップがチェックされているか確認
        bool allStepsChecked = true;
        if (updatedSteps.isNotEmpty) {
          allStepsChecked = updatedSteps.every((s) => s.isChecked);
        }

        // 更新されたステップリストを持つToDoを作成
        // ステップが全てチェックされていれば、親ToDoもチェック
        final updatedTodo = todo.copyWith(
          steps: updatedSteps,
          isChecked: allStepsChecked,
        );

        // ワークスペースのToDoリストを更新
        final updatedWorkspace = _updateWorkspaceTodos(
          workspacesAsync[index],
          updatedTodo,
          null,
          true,
        );

        final updatedWorkspaces = List<TLWorkspace>.from(workspacesAsync);
        updatedWorkspaces[index] = updatedWorkspace;

        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspaces(updatedWorkspaces);

        state = AsyncValue<List<TLWorkspace>>.data(updatedWorkspaces);
      }
    } catch (e, stack) {
      state = AsyncValue<List<TLWorkspace>>.error(
        e,
        stack,
      ).copyWithPrevious(state);
    }
  }

  // チェック済みのToDoをすべて削除するヘルパーメソッド
  TLWorkspace _deleteAllCheckedTodos(TLWorkspace workspace, bool ifInToday) {
    final workspaceIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
      workspace.workspaceIDToToDos,
    );
    final todosInTodayAndWhenever = workspaceIDToToDos[workspace.id]!;

    if (ifInToday) {
      final todosInToday =
          todosInTodayAndWhenever.toDosInToday
              .where((t) => !t.isChecked)
              .toList();

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInToday: todosInToday,
      );
    } else {
      final todosInWhenever =
          todosInTodayAndWhenever.toDosInWhenever
              .where((t) => !t.isChecked)
              .toList();

      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInWhenever: todosInWhenever,
      );
    }

    return workspace.copyWith(workspaceIDToToDos: workspaceIDToToDos);
  }

  // ワークスペースのToDoリストを並べ替えるヘルパーメソッド
  TLWorkspace _reorderWorkspaceTodos(
    TLWorkspace workspace,
    List<TLToDo> reorderedTodos,
    bool ifInToday,
  ) {
    final workspaceIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
      workspace.workspaceIDToToDos,
    );
    final todosInTodayAndWhenever = workspaceIDToToDos[workspace.id]!;

    if (ifInToday) {
      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInToday: reorderedTodos,
      );
    } else {
      workspaceIDToToDos[workspace.id] = todosInTodayAndWhenever.copyWith(
        toDosInWhenever: reorderedTodos,
      );
    }

    return workspace.copyWith(workspaceIDToToDos: workspaceIDToToDos);
  }
}
