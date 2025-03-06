import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

import 'package:reorderables/reorderables.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card/tl_todo_card.dart';

class ListOfCategoryToToDos extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;

  const ListOfCategoryToToDos({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLToDosInTodayAndWhenever? corrToDos =
        corrWorkspace.workspaceIDToToDos[corrWorkspace.id];
    // カテゴリーへ分類されていない ToDo がある場合のみ表示
    if (corrToDos!.getToDos(ifInToday).isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ReorderableColumn(
          children: [
            for (TLToDo corrToDo in corrWorkspace
                .workspaceIDToToDos[corrWorkspace.id]!
                .getToDos(ifInToday))
              TLToDoCard(
                key: ValueKey(corrToDo.id),
                corrWorkspace: corrWorkspace,
                corrToDo: corrToDo,
                ifInToday: ifInToday,
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            ref.read(tlAppStateProvider.notifier).updateState(
                  TLToDoAction.reorderToDo(
                    corrWorkspace: corrWorkspace,
                    workspaceID: corrWorkspace.id,
                    ifInToday: ifInToday,
                    oldIndex: oldIndex,
                    newIndex: newIndex,
                  ),
                );
          },
        ),
      ],
    );
  }
}
