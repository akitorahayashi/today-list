import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInCategory extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final String categoryID;
  final bool isBigCategory;

  const ToDosInCategory({
    super.key,
    required this.corrWorkspace,
    required this.categoryID,
    required this.ifInToday,
    required this.isBigCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: isBigCategory ? 5 : 18),
          child: ReorderableColumn(
            children: [
              for (TLToDo corrToDo in corrWorkspace
                  .categoryIDToToDos[categoryID]!
                  .getToDos(ifInToday))
                TLToDoCard(
                  key: ValueKey(corrToDo.id),
                  corrWorkspace: corrWorkspace,
                  corrToDo: corrToDo,
                  ifInToday: ifInToday,
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              ref.read(tlAppStateProvider.notifier).dispatch(
                    TLToDoAction.reorderToDo(
                      corrWorkspace: corrWorkspace,
                      categoryID: categoryID,
                      ifInToday: ifInToday,
                      oldIndex: oldIndex,
                      newIndex: newIndex,
                    ),
                  );
            },
          ),
        ),
      ],
    );
  }
}
