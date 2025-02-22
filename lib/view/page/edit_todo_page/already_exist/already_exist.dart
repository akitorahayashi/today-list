import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'model_of_todo_card.dart';

class AlreadyExist extends StatelessWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final String bigCategoryID;
  final String? smallCategoryID;

  const AlreadyExist({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.bigCategoryID,
    required this.smallCategoryID,
  });

  @override
  Widget build(BuildContext context) {
    // others
    final String categoryOfThisToDo = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisBlock = corrWorkspace
            .categoryIDToToDos[categoryOfThisToDo]
            ?.getToDos(ifInToday) ??
        [];

    // `toDoArrayOfThisBlock` が空の場合は何も表示しない
    if (toDoArrayOfThisBlock.isEmpty) {
      return const SizedBox.shrink();
    }

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
                  ifInToday: ifInToday,
                  corrTLToDo: toDoArrayOfThisBlock[indexOfThisToDoInToDos],
                  // 編集系のメンバー
                  // tapToEditAction: tapToEditAction,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
