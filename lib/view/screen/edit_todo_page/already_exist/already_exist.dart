import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'model_of_todo_card.dart';

class AlreadyExist extends ConsumerWidget {
  final String bigCategoryID;
  final String? smallCategoryID;
  final bool ifInToday;
  final Function tapToEditAction;
  const AlreadyExist({
    super.key,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.ifInToday,
    required this.tapToEditAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // others
    final TLWorkspace currentWorkspaceReference =
        tlAppState.getCurrentWorkspace;
    // others
    final String categoryOfThisToDo = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisBlock = currentWorkspaceReference
            .categoryIDToToDos[categoryOfThisToDo]
            ?.getToDos(ifInToday) ??
        [];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              for (int indexOfThisToDoInToDos = 0;
                  indexOfThisToDoInToDos < toDoArrayOfThisBlock.length;
                  indexOfThisToDoInToDos++)
                ModelOfToDoCard(
                  key:
                      ValueKey(toDoArrayOfThisBlock[indexOfThisToDoInToDos].id),
                  // todoのメンバー
                  corrTLToDo: toDoArrayOfThisBlock[indexOfThisToDoInToDos],
                  ifInToday: ifInToday,
                  bigCategoryID: bigCategoryID,
                  smallCategoryID: smallCategoryID,
                  indexOfThisToDoInToDoArrray: indexOfThisToDoInToDos,
                  // 編集系のメンバー
                  indexOfEditingToDo: indexOfThisToDoInToDos,
                  tapToEditAction: tapToEditAction,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
