import '../todo_card/todo_card.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';
import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInThisCategoryInToday extends StatefulWidget {
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;

  final int selectedWorkspaceIndex;
  final TLWorkspace selectedWorkspace;

  List<TLToDo> get toDosInTodayInThisCategory => selectedWorkspace
      .toDos[smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]!
      .toDosInToday;

  const ToDosInThisCategoryInToday({
    Key? key,
    required this.bigCategoryOfThisToDo,
    this.smallCategoryOfThisToDo,
    // workspace系
    required this.selectedWorkspaceIndex,
    required this.selectedWorkspace,
  }) : super(key: key);

  @override
  State<ToDosInThisCategoryInToday> createState() =>
      _ToDosInThisCategoryInTodayState();
}

class _ToDosInThisCategoryInTodayState
    extends State<ToDosInThisCategoryInToday> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: widget.smallCategoryOfThisToDo == null ? 5 : 18),
          child: ReorderableColumn(
              children: [
                for (int indexOfThisToDoInToDos = 0;
                    indexOfThisToDoInToDos <
                        widget.toDosInTodayInThisCategory.length;
                    indexOfThisToDoInToDos++)
                  ToDoCard(
                    key: Key(widget
                        .toDosInTodayInThisCategory[indexOfThisToDoInToDos].id),
                    ifInToday: true,
                    indexOfThisToDoInToDos: indexOfThisToDoInToDos,
                    bigCategoryOfThisToDo: widget.bigCategoryOfThisToDo,
                    smallCategoryOfThisToDo: widget.smallCategoryOfThisToDo,
                    // workspace
                    selectedWorkspaceIndex: widget.selectedWorkspaceIndex,
                    selectedWorkspace: widget.selectedWorkspace,
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                final int indexOfCheckedToDo = widget.toDosInTodayInThisCategory
                    .indexWhere((todo) => todo.isChecked);
                if (indexOfCheckedToDo == -1 || indexOfCheckedToDo > newIndex) {
                  final TLToDo reorderedToDo =
                      widget.toDosInTodayInThisCategory.removeAt(oldIndex);
                  widget.toDosInTodayInThisCategory
                      .insert(newIndex, reorderedToDo);
                  // toDosを保存する
                  TLWorkspace.saveSelectedWorkspace(
                      selectedWorkspaceIndex: widget.selectedWorkspaceIndex);
                }
              }),
        ),
      ],
    );
  }
}
