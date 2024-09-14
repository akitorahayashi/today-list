import 'package:flutter/material.dart';
import '../../constants/global_keys.dart';
import '../../components/for_todo/todo_card/todo_card.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/tl_category.dart';
import '../../model/workspace/workspace.dart';

import 'package:reorderables/reorderables.dart';

class ToDoBlockInTodayOrWhenever extends StatefulWidget {
  final bool ifInToday;
  final TLCategory bigCategoryThisPage;
  final TLCategory? smallCategoryThisPage;

  TLCategory get categoryThisPage =>
      smallCategoryThisPage ?? bigCategoryThisPage;

  const ToDoBlockInTodayOrWhenever({
    super.key,
    required this.ifInToday,
    required this.bigCategoryThisPage,
    required this.smallCategoryThisPage,
  });

  List<TLToDo> get toDoArrayOfThisBlock => ifInToday
      ? currentWorkspace.toDos[categoryThisPage.id]!.toDosInToday
      : currentWorkspace.toDos[categoryThisPage.id]!.toDosInWhenever;

  @override
  State<ToDoBlockInTodayOrWhenever> createState() =>
      _ToDoBlockInTodayOrWheneverState();
}

class _ToDoBlockInTodayOrWheneverState
    extends State<ToDoBlockInTodayOrWhenever> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 「今日」header
        Container(
          height: 30,
          margin: const EdgeInsets.only(left: 12, top: 10),
          child: Text(widget.ifInToday ? "今日" : "いつでも",
              style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45)),
        ),
        // このカテゴリーのtodoのうち、今日またはいつでものtodoを表示する
        ReorderableColumn(
          onReorder: ((oldIndex, newIndex) {
            final int indexOfCheckedToDo = widget.toDoArrayOfThisBlock
                .indexWhere((todo) => todo.isChecked);
            if (indexOfCheckedToDo == -1 || indexOfCheckedToDo > newIndex) {
              final TLToDo reorderedToDo =
                  widget.toDoArrayOfThisBlock.removeAt(oldIndex);
              widget.toDoArrayOfThisBlock.insert(newIndex, reorderedToDo);
              allToDosInCategoryPageKey.currentState?.setState(() {});
            }
          }),
          children: [
            for (int indexOfThisToDoInToDos = 0;
                indexOfThisToDoInToDos < widget.toDoArrayOfThisBlock.length;
                indexOfThisToDoInToDos++)
              ToDoCard(
                key: Key(UniqueKey().toString()),
                superKey: allToDosInCategoryPageKey,
                ifInToday: widget.ifInToday,
                indexOfThisToDoInToDos: indexOfThisToDoInToDos,
                bigCategoryOfThisToDo: widget.bigCategoryThisPage,
                smallCategoryOfThisToDo: widget.smallCategoryThisPage,
                // workspace
                selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                selectedWorkspaceIndex: currentWorkspaceIndex,
                selectedWorkspace: currentWorkspace,
              )
          ],
        ),
      ],
    );
  }
}
