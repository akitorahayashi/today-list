import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';
import 'model_of_todo_card.dart';

class AlreadyExist extends StatelessWidget {
  final TLWorkspace corrWorkspace;

  const AlreadyExist({super.key, required this.corrWorkspace});

  @override
  Widget build(BuildContext context) {
    // Todayのタスク一覧を取得
    final List<TLToDo> todayToDos =
        corrWorkspace.workspaceIDToToDos[corrWorkspace.id]?.getToDos(true) ??
        [];

    // Wheneverのタスク一覧を取得
    final List<TLToDo> wheneverToDos =
        corrWorkspace.workspaceIDToToDos[corrWorkspace.id]?.getToDos(false) ??
        [];

    // タスクの数を取得
    final numOfToDosInToday = todayToDos.length;
    final numOfToDosInWhenever = wheneverToDos.length;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        children: [
          // Todayセクション
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: NumToDosCard(title: "In Today", numTodos: numOfToDosInToday),
          ),
          _buildToDoList(context, todayToDos, true),

          // Wheneverセクション
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: NumToDosCard(
              title: "In Whenever",
              numTodos: numOfToDosInWhenever,
            ),
          ),
          _buildToDoList(context, wheneverToDos, false),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  // ToDoリストを構築するヘルパーメソッド
  Widget _buildToDoList(
    BuildContext context,
    List<TLToDo> todos,
    bool ifInToday,
  ) {
    if (todos.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        for (int index = 0; index < todos.length; index++)
          Padding(
            padding: const EdgeInsets.only(top: 1.2),
            child: ModelOfToDoCard(
              key: ValueKey(todos[index].id),
              corrWorkspace: corrWorkspace,
              ifInToday: ifInToday,
              corrTLToDo: todos[index],
            ),
          ),
      ],
    );
  }
}
