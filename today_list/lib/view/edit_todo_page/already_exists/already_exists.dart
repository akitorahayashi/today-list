import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/tl_workspace.dart';
import './model_of_todo_card.dart';

import 'package:reorderables/reorderables.dart';

class AlreadyExists extends ConsumerWidget {
  final String bigCategoryID;
  final String? smallCategoryID;
  final bool ifInToday;
  final Function tapToEditAction;
  const AlreadyExists({
    super.key,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.ifInToday,
    required this.tapToEditAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    // notifier
    final CurrentTLWorkspaceNotifier currentWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    // others
    final String categoryOfThisToDo = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisBlock =
        currentWorkspace.toDos[categoryOfThisToDo]![ifInToday];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // 文字
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Already Exists",
                        style: TextStyle(
                          color: tlThemeData.accentColor,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              ReorderableColumn(
                  children: [
                    for (int indexOfThisToDoInToDos = 0;
                        indexOfThisToDoInToDos < toDoArrayOfThisBlock.length;
                        indexOfThisToDoInToDos++)
                      ModelOfToDoCard(
                        key: ValueKey(
                            toDoArrayOfThisBlock[indexOfThisToDoInToDos].id),
                        // todoのメンバー
                        corrTLToDo:
                            toDoArrayOfThisBlock[indexOfThisToDoInToDos],
                        ifInToday: ifInToday,
                        bigCategoryID: bigCategoryID,
                        smallCategoryID: smallCategoryID,
                        indexOfThisToDoInToDoArrray: indexOfThisToDoInToDos,
                        // 編集系のメンバー
                        indexOfEditingToDo: indexOfThisToDoInToDos,
                        tapToEditAction: tapToEditAction,
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    List<TLToDo> corrToDoArray = currentWorkspace
                        .toDos[categoryOfThisToDo.id]![ifInToday];
                    final int indexOfCheckedToDo =
                        corrToDoArray.indexWhere((todo) => todo.isChecked);
                    // チェック済みToDoよりも下に移動させない
                    if (indexOfCheckedToDo == -1 ||
                        newIndex < indexOfCheckedToDo) {
                      final TLToDo reorderedToDo =
                          corrToDoArray.removeAt(oldIndex);
                      corrToDoArray.insert(newIndex, reorderedToDo);
                      // toDosを保存する
                      tlWorkspacesNotifier.updateSpecificTLWorkspace(
                          specificWorkspaceIndex:
                              currentWorkspaceNotifier.currentTLWorkspaceIndex,
                          updatedWorkspace: currentWorkspace);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
