import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/action/todo_action.dart';
import 'package:today_list/flux/dispatcher/todo_dispatcher.dart';

import 'package:reorderables/reorderables.dart';
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
    final TLToDosInTodayAndWhenever corrToDos = corrWorkspace.toDos;
    // カテゴリーへ分類されていない ToDo がある場合のみ表示
    if (corrToDos.getToDos(ifInToday).isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ReorderableColumn(
          children: [
            for (TLToDo corrToDo in corrWorkspace.toDos.getToDos(ifInToday))
              TLToDoCard(
                key: ValueKey(corrToDo.id),
                corrWorkspace: corrWorkspace,
                corrToDo: corrToDo,
                ifInToday: ifInToday,
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            // Fluxパターンを使用してToDoの並び替えを実行
            TodoDispatcher.dispatch(
              ref,
              TodoAction.reorderTodos(
                workspace: corrWorkspace,
                todos: corrToDos.getToDos(ifInToday),
                oldIndex: oldIndex,
                newIndex: newIndex,
                category: "", // カテゴリは使用しない
                ifInToday: ifInToday,
              ),
            );
          },
        ),
      ],
    );
  }
}
