import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import '../../component/todo_card/tl_todo_card.dart';
import '../../../model/todo/tl_workspace.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInThisCategoryInCurrentWorkspace extends ConsumerWidget {
  final bool ifInToday;
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;

  const ToDosInThisCategoryInCurrentWorkspace({
    super.key,
    required this.ifInToday,
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final tlWorksapceState = ref.watch(tlWorkspacesStateProvider);
    final TLWorkspace currentTLWorkspace = tlWorksapceState.currentWorkspace;
    // notifier
    final tlWorksapceStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    final coorCategoryIDToToDos =
        Map<String, TLToDos>.from(currentTLWorkspace.categoryIDToToDos);
    List<TLToDo> toDosInTodayInThisCategory = coorCategoryIDToToDos[
        smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]![ifInToday];
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
                  final TLToDo reorderedToDo =
                      toDosInTodayInThisCategory.removeAt(oldIndex);
                  toDosInTodayInThisCategory.insert(newIndex, reorderedToDo);

                  // 更新されたワークスペースを保存
                  tlWorksapceStateNotifier.updateCurrentWorkspace(
                    updatedCurrentWorkspace: currentTLWorkspace.copyWith(
                        categoryIDToToDos: coorCategoryIDToToDos),
                  );
                }
              }),
        ),
      ],
    );
  }
}
