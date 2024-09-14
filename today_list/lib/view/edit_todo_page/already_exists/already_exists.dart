import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../constants/global_keys.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/tl_category.dart';
import '../../../model/workspace/workspace.dart';
import '../../../model/user/setting_data.dart';
import './model_of_todo_card.dart';

import 'package:reorderables/reorderables.dart';

class AlreadyExists extends StatefulWidget {
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;
  final bool ifInToday;
  final Function tapToEditAction;
  const AlreadyExists({
    super.key,
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
    required this.ifInToday,
    required this.tapToEditAction,
  });

  @override
  State<AlreadyExists> createState() => _AlreadyExistsState();
}

class _AlreadyExistsState extends State<AlreadyExists> {
  @override
  Widget build(BuildContext context) {
    final TLCategory categoryOfThisToDo =
        widget.smallCategoryOfThisToDo ?? widget.bigCategoryOfThisToDo;
    final List<TLToDo> toDoArrayOfThisBlock = currentWorkspace
        .toDos[categoryOfThisToDo.id]!
        .getToDoArray(inToday: widget.ifInToday);
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
                        settingData.englishMode ? "Already Exists" : "追加済み",
                        style: TextStyle(
                          color: theme[settingData.selectedTheme]!.accentColor,
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
                        key: Key(UniqueKey().toString()),
                        // todoのメンバー
                        toDoData: toDoArrayOfThisBlock[indexOfThisToDoInToDos],
                        ifInToday: widget.ifInToday,
                        bigCategoryOfThisToDo: widget.bigCategoryOfThisToDo,
                        smallCategoryOfThisToDo: widget.smallCategoryOfThisToDo,
                        indexOfThisToDoInToDoArrray: indexOfThisToDoInToDos,
                        // 編集系のメンバー
                        indexOfEditingToDo: indexOfThisToDoInToDos,
                        tapToEditAction: widget.tapToEditAction,
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    List<TLToDo> selectedToDoArray = currentWorkspace
                        .toDos[categoryOfThisToDo.id]!
                        .getToDoArray(inToday: widget.ifInToday);
                    final int indexOfCheckedToDo =
                        selectedToDoArray.indexWhere((todo) => todo.isChecked);
                    if (indexOfCheckedToDo == -1 ||
                        indexOfCheckedToDo > newIndex) {
                      final TLToDo reorderedToDo =
                          selectedToDoArray.removeAt(oldIndex);
                      selectedToDoArray.insert(newIndex, reorderedToDo);
                      editToDoPageKey.currentState?.setState(() {});
                      // toDosを保存する
                      Workspace.saveSelectedWorkspace(
                          selectedWorkspaceCategoryId:
                              currentWorkspaceCategoryId,
                          selectedWorkspaceIndex: currentWorkspaceIndex,
                          selectedWorkspace: currentWorkspace);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
