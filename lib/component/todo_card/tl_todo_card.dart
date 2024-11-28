import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/workspace/tl_workspaces_state.dart';
import '../../component/todo_card/tl_checkbox.dart';
import '../../component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/workspace/tl_workspace.dart';
import 'tl_step_card.dart';
import '../slidable/slidable_for_todo_card.dart';

import 'package:reorderables/reorderables.dart';

class TLToDoCard extends ConsumerWidget {
  final bool ifInToday;
  final int indexOfThisToDoInToDos;
  final TLCategory bigCategoryOfThisToDo;
  // smallCategoryならこれがある
  final TLCategory? smallCategoryOfThisToDo;

  const TLToDoCard({
    super.key,
    required this.ifInToday,
    required this.indexOfThisToDoInToDos,
    required this.bigCategoryOfThisToDo,
    this.smallCategoryOfThisToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace =
        ref.watch(tlWorkspacesStateProvider).currentWorkspace;
    // notifier
    final TLWorkspacesStateNotifier tlWorkspacesStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    // category
    final TLCategory categoryOfThisToDo = smallCategoryOfThisToDo == null
        ? bigCategoryOfThisToDo
        : smallCategoryOfThisToDo!;

    List<TLToDo> toDoArrayThatContainsThisToDo =
        currentTLWorkspace.categoryIDToToDos[categoryOfThisToDo.id]![ifInToday];

    final TLToDo corrToDoData =
        toDoArrayThatContainsThisToDo[indexOfThisToDoInToDos];
    // 全体を囲むカード
    return GestureDetector(
      onTap: () {
        final copiedCurrentTLWorkspace = currentTLWorkspace.copyWith();
        final copiedCorrToDoData = copiedCurrentTLWorkspace
                .categoryIDToToDos[categoryOfThisToDo.id]![ifInToday]
            [indexOfThisToDoInToDos];
        // チェックの状態を切り替える
        copiedCorrToDoData.isChecked = !copiedCorrToDoData.isChecked;
        // stepsがあるならその全てのstepsのcheck状態を同じにする
        for (TLStep step in corrToDoData.steps) {
          step.isChecked = corrToDoData.isChecked;
        }
        // 並び替え
        copiedCurrentTLWorkspace.reorderWhenToggle(
          categoryId: categoryOfThisToDo.id,
          ifInToday: ifInToday,
          indexOfThisToDoInToDos: indexOfThisToDoInToDos,
        );
        // 保存
        TLVibration.vibrate();
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: corrToDoData.title,
          newCheckedState: corrToDoData.isChecked,
          quickChangeToToday: null,
        );
        tlWorkspacesStateNotifier.updateCurrentWorkspace(
          updatedCurrentWorkspace: copiedCurrentTLWorkspace,
        );
      },
      // チェック済みのreorder阻止のためのlongPress
      onLongPress: corrToDoData.isChecked ? () {} : null,
      child: Card(
          // 色
          color: tlThemeData.panelColor,
          // 浮き具合
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SlidableForToDoCard(
              isForModelCard: false,
              corrTLToDo: corrToDoData,
              indexOfThisToDoInToDos: indexOfThisToDoInToDos,
              ifInToday: ifInToday,
              // category
              bigCategoryID: bigCategoryOfThisToDo.id,
              smallCategoryID: smallCategoryOfThisToDo?.id,
              // child
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        16, 18, 16, corrToDoData.steps.isNotEmpty ? 15 : 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 左側のチェックボックス
                        Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                            // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            child: Transform.scale(
                              scale: 1.2,
                              child:
                                  TLCheckBox(isChecked: corrToDoData.isChecked),
                            )),
                        // toDoのタイトル
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              corrToDoData.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(
                                      corrToDoData.isChecked ? 0.3 : 0.6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // stepsのリスト
                  if (corrToDoData.steps.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ReorderableColumn(
                        children: List<Widget>.generate(
                            corrToDoData.steps.length,
                            (int indexOfThisStepInToDo) => Padding(
                                  key: ValueKey(UniqueKey().toString()),
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 2, 0),
                                  child: TLStepCard(
                                    corrCategoryID: categoryOfThisToDo.id,
                                    ifInToday: ifInToday,
                                    indexInToDos: indexOfThisToDoInToDos,
                                    indexInSteps: indexOfThisStepInToDo,
                                  ),
                                )),
                        onReorder: (oldIndex, newIndex) {
                          final copiedCurrentTLWorkspace =
                              currentTLWorkspace.copyWith();
                          final copiedCorrToDoData = copiedCurrentTLWorkspace
                                  .categoryIDToToDos[categoryOfThisToDo.id]![
                              ifInToday][indexOfThisToDoInToDos];
                          if (oldIndex == newIndex) return;
                          final reOrderedToDo =
                              copiedCorrToDoData.steps[oldIndex];
                          copiedCorrToDoData.steps.remove(reOrderedToDo);
                          copiedCorrToDoData.steps
                              .insert(newIndex, reOrderedToDo);
                          // toDosを保存する
                          tlWorkspacesStateNotifier.updateCurrentWorkspace(
                            updatedCurrentWorkspace: copiedCurrentTLWorkspace,
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          )),
    );
  }
}
