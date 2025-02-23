import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/util/tl_workspace_utils.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/list_of_category_to_todos/list_of_category_to_todos.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';

class ToDoListInWorkspaceInTodayAndWhenever extends StatelessWidget {
  final TLWorkspace corrWorkspace;

  const ToDoListInWorkspaceInTodayAndWhenever(
      {super.key, required this.corrWorkspace});

  @override
  Widget build(BuildContext context) {
    final numOfToDosInToday = TLWorkspaceUtils.getNumOfToDoInWorkspace(
        corrWorkspace,
        ifInToday: true);
    final numOfToDosInWhenever = TLWorkspaceUtils.getNumOfToDoInWorkspace(
        corrWorkspace,
        ifInToday: false);

    return ListView(
      key: PageStorageKey(corrWorkspace.id), // スクロール位置を保持
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: NumToDosCard(title: null, numTodos: numOfToDosInToday),
        ),
        ListOfCategoryToToDos(ifInToday: true, corrWorkspace: corrWorkspace),
        if (numOfToDosInWhenever != 0)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: NumToDosCard(
                title: "In Whenever", numTodos: numOfToDosInWhenever),
          ),
        ListOfCategoryToToDos(ifInToday: false, corrWorkspace: corrWorkspace),
        const SizedBox(height: 250),
      ],
    );
  }
}
