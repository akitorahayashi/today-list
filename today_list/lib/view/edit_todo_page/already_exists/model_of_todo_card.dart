import 'package:flutter/material.dart';
import 'package:today_list/components/for_todo/icon_for_checkbox.dart';
import '../../../model/tl_theme.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../components/for_todo/todo_card/slidable_for_todo_card.dart';

import 'package:reorderables/reorderables.dart';

class ModelOfToDoCard extends StatelessWidget {
  // todoのデータ
  final TLToDo toDoData;
  final bool ifInToday;
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;
  final int indexOfThisToDoInToDoArrray;
  // 編集系の変数
  final int? indexOfEditingToDo;
  final Function tapToEditAction;
  const ModelOfToDoCard({
    Key? key,
    // todoのデータ
    required this.toDoData,
    required this.ifInToday,
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
    required this.indexOfThisToDoInToDoArrray,
    // 編集系の変数
    required this.indexOfEditingToDo,
    required this.tapToEditAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Card(
      color: _tlThemeData.panelColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SlidableForToDoCard(
          isModelCard: true,
          toDoData: toDoData,
          ifInToday: ifInToday,
          toDoArrayOfThisToDo: TLWorkspace.currentWorkspace
              .toDos[smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id]!
              .getToDoArray(inToday: ifInToday),
          bigCategoryOfThisToDo: bigCategoryOfThisToDo,
          smallCategoryOfThisToDo: smallCategoryOfThisToDo,
          indexOfThisToDoInToDos: indexOfThisToDoInToDoArrray,
          selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex,
          selectedWorkspace: TLWorkspace.currentWorkspace,
          editAction: tapToEditAction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 選択した日があれば表示
              // if (toDoData.scheduledDate != null)
              //   Padding(
              //     padding: const EdgeInsets.only(left: 16.0, top: 10.0),
              //     child: Align(
              //         alignment: Alignment.bottomLeft,
              //         child: Text(
              //           toDoData.scheduledDate!,
              //           style: TextStyle(
              //               color: theme[settingData.selectedTheme]!
              //                   .accentColor
              //                   .withOpacity(0.9),
              //               fontWeight: FontWeight.w600,
              //               fontSize: 12),
              //         )),
              //   ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    16,
                    // toDoData.scheduledDate != null ? 10 :
                    18,
                    16,
                    toDoData.steps.isNotEmpty ? 15 : 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // 左側のチェックボックス
                    Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                        // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Transform.scale(
                          scale: 1.2,
                          child: IconForCheckBox(isChecked: toDoData.isChecked),
                        )),
                    // toDoのタイトル
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          toDoData.title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                                  .withOpacity(toDoData.isChecked ? 0.3 : 0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // steps
              if (toDoData.steps.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ReorderableColumn(
                    children: toDoData.steps.map((stepData) {
                      return Padding(
                        key: Key(UniqueKey().toString()),
                        padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Row(
                              children: [
                                // 左側のチェックボックス
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 16, 0),
                                  child: Transform.scale(
                                    scale: 1.2,
                                    child: IconForCheckBox(
                                        isChecked: stepData.isChecked),
                                  ),
                                ),
                                // stepのタイトル
                                Expanded(
                                  child: Text(stepData.title,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(
                                              stepData.isChecked ? 0.3 : 0.6))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex != newIndex) {
                        final reOrderedToDo = toDoData.steps[oldIndex];
                        toDoData.steps.remove(reOrderedToDo);
                        toDoData.steps.insert(newIndex, reOrderedToDo);
                        // toDosを保存する
                        TLWorkspace.saveSelectedWorkspace(
                            selectedWorkspaceIndex:
                                TLWorkspace.currentWorkspaceIndex);
                      }
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
