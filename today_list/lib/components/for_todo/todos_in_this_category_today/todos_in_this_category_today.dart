import '../todo_card/todo_card.dart';
import '../../../model/workspace/workspace.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/tl_category.dart';
import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class ToDosInThisCategoryInToday extends StatefulWidget {
  final GlobalKey superKey;
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;

  final String selectedWorkspaceCategoryId;
  final int selectedWorkspaceIndex;
  final TLWorkspace selectedWorkspace;

  List<TLToDo> get toDosInTodayInThisCategory => selectedWorkspace
      .toDos[smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]!
      .toDosInToday;

  const ToDosInThisCategoryInToday({
    super.key,
    required this.superKey,
    required this.bigCategoryOfThisToDo,
    this.smallCategoryOfThisToDo,
    // workspace系
    required this.selectedWorkspaceCategoryId,
    required this.selectedWorkspaceIndex,
    required this.selectedWorkspace,
  });

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
                    key: Key(UniqueKey().toString()),
                    superKey: widget.superKey,
                    ifInToday: true,
                    indexOfThisToDoInToDos: indexOfThisToDoInToDos,
                    bigCategoryOfThisToDo: widget.bigCategoryOfThisToDo,
                    smallCategoryOfThisToDo: widget.smallCategoryOfThisToDo,
                    // workspace
                    selectedWorkspaceCategoryId:
                        widget.selectedWorkspaceCategoryId,
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
                  widget.superKey.currentState?.setState(() {});
                  // toDosを保存する
                  TLWorkspace.saveSelectedWorkspace(
                    selectedWorkspaceCategoryId:
                        widget.selectedWorkspaceCategoryId,
                    selectedWorkspaceIndex: widget.selectedWorkspaceIndex,
                    selectedWorkspace: widget.selectedWorkspace,
                  );
                }
              }),
        ),
      ],
    );
  }
}
