import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import '../../../../component/todo_card/tl_todo_card.dart';
import '../../../../../model/todo/tl_workspace.dart';
import '../../../../../model/todo/tl_todo.dart';
import '../../../../../model/todo/tl_category.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInCategory extends ConsumerWidget {
  final bool ifInToday;
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;

  const ToDosInCategory({
    super.key,
    required this.ifInToday,
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    final TLWorkspace currentTLWorkspaceReference =
        tlAppState.getCurrentWorkspace;
    // notifier
    final tlAppStateNotifier = ref.read(tlAppStateProvider.notifier);
    // others
    final coorCategoryIDToToDos = Map<String, TLToDosInTodayAndWhenever>.from(
        currentTLWorkspaceReference.categoryIDToToDos);

    List<TLToDo> toDosInTodayInThisCategory = coorCategoryIDToToDos[
            smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]!
        .getToDos(ifInToday);

    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: smallCategoryOfThisToDo == null ? 5 : 18),
          child: ReorderableColumn(
            children: [
              for (int i = 0; i < toDosInTodayInThisCategory.length; i++)
                TLToDoCard(
                  key: ValueKey(toDosInTodayInThisCategory[i].id),
                  ifInToday: ifInToday,
                  indexOfThisToDoInToDos: i,
                  bigCategoryOfThisToDo: bigCategoryOfThisToDo,
                  smallCategoryOfThisToDo: smallCategoryOfThisToDo,
                ),
            ],
            onReorder: (oldIndex, newIndex) {
              final int indexOfCheckedToDo = toDosInTodayInThisCategory
                  .indexWhere((todo) => todo.isChecked);

              if (indexOfCheckedToDo == -1 || newIndex < indexOfCheckedToDo) {
                // 新しいリストを生成
                final List<TLToDo> updatedToDos =
                    List.from(toDosInTodayInThisCategory);
                final TLToDo reorderedToDo = updatedToDos.removeAt(oldIndex);
                updatedToDos.insert(newIndex, reorderedToDo);

                // `categoryIDToToDos` を再構築
                final updatedCategoryIDToToDos = {
                  ...coorCategoryIDToToDos,
                  (smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id):
                      coorCategoryIDToToDos[smallCategoryOfThisToDo?.id ??
                              bigCategoryOfThisToDo.id]!
                          .copyWith(toDosInToday: updatedToDos),
                };

                // 更新されたワークスペースを保存
                tlAppStateNotifier.dispatchWorkspaceAction(
                    TLWorkspaceAction.updateCurrentWorkspace(
                        currentTLWorkspaceReference.copyWith(
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
