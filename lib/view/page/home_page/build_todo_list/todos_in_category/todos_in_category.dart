import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/todo_card/tl_todo_card.dart';

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
              final TLToDosInTodayAndWhenever copiedTLToDosInTodayAndWhenever =
                  corrWorkspace.categoryIDToToDos[categoryID]!.copyWith();

              final List<TLToDo> corrToDoArray = List.from(
                  copiedTLToDosInTodayAndWhenever.getToDos(ifInToday));

              final int indexOfCheckedToDo =
                  corrToDoArray.indexWhere((todo) => todo.isChecked);

              if (indexOfCheckedToDo == -1 || newIndex < indexOfCheckedToDo) {
                final TLToDo reorderedToDo = corrToDoArray.removeAt(oldIndex);
                corrToDoArray.insert(newIndex, reorderedToDo);
                late final Map<String, TLToDosInTodayAndWhenever>
                    updatedCategoryIDToToDos;
                // `categoryIDToToDos` を再構築
                if (ifInToday) {
                  updatedCategoryIDToToDos = {
                    ...corrWorkspace.categoryIDToToDos,
                    categoryID: copiedTLToDosInTodayAndWhenever.copyWith(
                        toDosInToday: corrToDoArray),
                  };
                } else {
                  updatedCategoryIDToToDos = {
                    ...corrWorkspace.categoryIDToToDos,
                    categoryID: copiedTLToDosInTodayAndWhenever.copyWith(
                        toDosInWhenever: corrToDoArray),
                  };
                }

                // 更新されたワークスペースを保存
                ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
                        TLWorkspaceAction.updateCorrWorkspace(
                            corrWorkspace.copyWith(
                      categoryIDToToDos: updatedCategoryIDToToDos,
                    )));
              }
            },
          ),
        ),
      ],
    );
  }
}
