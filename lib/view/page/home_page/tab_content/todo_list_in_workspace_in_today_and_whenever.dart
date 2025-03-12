import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/list_of_category_to_todos.dart';
import 'package:today_list/view/page/home_page/tab_content/build_todo_list/num_todos_card.dart';

class ToDoListInWorkspaceInTodayAndWhenever extends StatelessWidget {
  final TLWorkspace corrWorkspace;

  const ToDoListInWorkspaceInTodayAndWhenever({
    super.key,
    required this.corrWorkspace,
  });

  @override
  Widget build(BuildContext context) {
    final numOfToDosInToday =
        corrWorkspace.getNumOfToDoInWorkspace(ifInToday: true);
    final numOfToDosInWhenever =
        corrWorkspace.getNumOfToDoInWorkspace(ifInToday: false);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: NumToDosCard(title: null, numTodos: numOfToDosInToday),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListOfCategoryToToDos(
              ifInToday: true, corrWorkspace: corrWorkspace),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: NumToDosCard(
              title: "In Whenever", numTodos: numOfToDosInWhenever),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListOfCategoryToToDos(
              ifInToday: false, corrWorkspace: corrWorkspace),
        ),
        const SizedBox(height: 250),
      ],
    );
  }
}
