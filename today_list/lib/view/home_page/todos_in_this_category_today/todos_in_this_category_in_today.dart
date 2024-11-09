import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import '../../../components/todo_card/tl_todo_card.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/tl_workspace.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInThisCategoryInToday extends ConsumerWidget {
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;

  const ToDosInThisCategoryInToday({
    super.key,
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final TLWorkspace currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    List<TLToDo> toDosInTodayInThisCategory = currentTLWorkspace
        .toDos[smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]!
        .toDosInToday;
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: smallCategoryOfThisToDo == null ? 5 : 18),
          child: ReorderableColumn(
              children: [
                for (int indexOfThisToDoInToDos = 0;
                    indexOfThisToDoInToDos < toDosInTodayInThisCategory.length;
                    indexOfThisToDoInToDos++)
                  TLToDoCard(
                    key: ValueKey(
                        toDosInTodayInThisCategory[indexOfThisToDoInToDos].id),
                    ifInToday: true,
                    indexOfThisToDoInToDos: indexOfThisToDoInToDos,
                    bigCategoryOfThisToDo: bigCategoryOfThisToDo,
                    smallCategoryOfThisToDo: smallCategoryOfThisToDo,
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                final int indexOfCheckedToDo = toDosInTodayInThisCategory
                    .indexWhere((todo) => todo.isChecked);
                if (indexOfCheckedToDo == -1 || indexOfCheckedToDo > newIndex) {
                  final TLToDo reorderedToDo =
                      toDosInTodayInThisCategory.removeAt(oldIndex);
                  toDosInTodayInThisCategory.insert(newIndex, reorderedToDo);

                  // 更新されたワークスペースを保存
                  tlWorkspacesNotifier.updateSpecificTLWorkspace(
                    specificWorkspaceIndex:
                        currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
                    updatedWorkspace: currentTLWorkspace,
                  );
                }
              }),
        ),
      ],
    );
  }
}
