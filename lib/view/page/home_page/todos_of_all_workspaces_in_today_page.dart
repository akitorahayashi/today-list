import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/view/page/home_page/build_todo_list/list_of_category_to_todos.dart';
import 'package:today_list/view/page/home_page/build_todo_list/num_todos_card.dart';

class TodoListOfAllWorkspacesInToday extends ConsumerWidget {
  const TodoListOfAllWorkspacesInToday({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<TLWorkspace> tlWorkspaces =
        ref.watch(tlAppStateProvider.select((state) => state.tlWorkspaces));

    return ListView(
      children: [
        const SizedBox(height: 12),
        for (TLWorkspace workspace in tlWorkspaces)
          TLDoubleCard(
              borderRadius: 12,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: NumToDosCard(title: workspace.name, numTodos: 0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListOfCategoryToToDos(
                        ifInToday: true, corrWorkspace: workspace),
                  ),
                ],
              )),
        const SizedBox(height: 200),
      ],
    );
  }
}
