import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/action/todo_action.dart';
import 'package:today_list/flux/store/todo_store.dart';

/// ToDoアクションのディスパッチャー
class TodoDispatcher {
  /// ToDoアクションをディスパッチする
  static void dispatch(WidgetRef ref, TodoAction action) async {
    await action.map(
      addTodo: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.addTodo(action.workspace, action.todo);
      },
      updateTodo: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.updateTodo(action.workspace, action.todo);
      },
      deleteTodo: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.deleteTodo(
          action.workspace,
          action.todo,
          action.ifInToday,
        );
      },
      toggleTodoCheck: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.toggleTodoCheck(
          action.workspace,
          action.todo,
          action.ifInToday,
        );
      },
      reorderTodos: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.reorderTodos(
          action.workspace,
          action.todos,
          action.oldIndex,
          action.newIndex,
          action.category,
          action.ifInToday,
        );
      },
      deleteAllCheckedTodos: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.deleteAllCheckedTodos(
          action.workspace,
          action.ifInToday,
        );
      },
      toggleStepCheck: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.toggleStepCheck(
          action.workspace,
          action.todo,
          action.step,
        );
      },
      toggleTodoTodayWhenever: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.toggleTodoTodayWhenever(action.workspace, action.todo);
      },
      reorderSteps: (action) async {
        final notifier = ref.read(todoProvider.notifier);
        await notifier.reorderSteps(
          action.workspace,
          action.todo,
          action.oldIndex,
          action.newIndex,
        );
      },
    );
  }
}
