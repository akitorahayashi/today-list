import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/todo_card/icon_for_checkbox.dart';
import 'package:today_list/components/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/model/workspace/current_tl_workspace_provider.dart';
import 'package:today_list/model/workspace/tl_workspaces_provider.dart';
import '../../model/design/tl_theme.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../view/edit_todo_page/edit_todo_page.dart';
import 'tl_step_card.dart';
import '../slidables/slidable_for_todo_card.dart';
import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class TLToDoCard extends ConsumerWidget {
  final bool ifInToday;
  final int indexOfThisToDoInToDos;
  final TLCategory bigCategoryOfThisToDo;
  // smallCategoryならこれがある
  final TLCategory? smallCategoryOfThisToDo;

  TLToDoCard({
    super.key,
    required this.ifInToday,
    required this.indexOfThisToDoInToDos,
    required this.bigCategoryOfThisToDo,
    this.smallCategoryOfThisToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace _currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    // category
    final TLCategory _categoryOfThisToDo = smallCategoryOfThisToDo == null
        ? bigCategoryOfThisToDo
        : smallCategoryOfThisToDo!;

    List<TLToDo> _toDoArrayThatContainsThisToDo =
        _currentTLWorkspace.toDos[_categoryOfThisToDo.id]![ifInToday];

    final TLToDo _corrToDoData =
        _toDoArrayThatContainsThisToDo[indexOfThisToDoInToDos];
    // 全体を囲むカード
    return GestureDetector(
      onTap: () {
        // チェックの状態を切り替える
        _corrToDoData.isChecked = !_corrToDoData.isChecked;
        // stepsがあるならその全てのstepsのcheck状態を同じにする
        for (TLStep step in _corrToDoData.steps) {
          step.isChecked = _corrToDoData.isChecked;
        }
        // 並び替え + 保存
        TLToDo.reorderWhenToggle(
            categoryId: _categoryOfThisToDo.id,
            indexOfThisToDoInToDos: indexOfThisToDoInToDos,
            toDoArrayOfThisToDo: _toDoArrayThatContainsThisToDo);
        TLVibration.vibrate();
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: _corrToDoData.title,
          newCheckedState: _corrToDoData.isChecked,
          quickChangeToToday: null,
        );
      },
      // チェック済みのreorder阻止のためのlongPress
      onLongPress: _corrToDoData.isChecked ? () {} : null,
      child: Card(
          // 色
          color: _tlThemeData.panelColor,
          // 浮き具合
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SlidableForToDoCard(
              isForModelCard: false,
              corrTLToDo: _corrToDoData,
              indexOfThisToDoInToDos: indexOfThisToDoInToDos,
              ifInToday: ifInToday,
              // category
              bigCategoryOfThisToDo: bigCategoryOfThisToDo,
              smallCategoryOfThisToDo: smallCategoryOfThisToDo,
              editAction: () async {
                // TODO タップしたらEditToDoCardをpushする
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return EditToDoPage(
                    toDoTitle: _corrToDoData.title,
                    belogedSteps: _corrToDoData.steps,
                    isInToday: ifInToday,
                    indexOfThisToDoInToDos: indexOfThisToDoInToDos,
                    bigCategory: bigCategoryOfThisToDo,
                    smallCategory: smallCategoryOfThisToDo,
                    oldCategoryId:
                        smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id,
                  );
                }));
              },
              // child
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        16, 18, 16, _corrToDoData.steps.isNotEmpty ? 15 : 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 左側のチェックボックス
                        Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                            // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                            child: Transform.scale(
                              scale: 1.2,
                              child: TLCheckBox(
                                  isChecked: _corrToDoData.isChecked),
                            )),
                        // toDoのタイトル
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _corrToDoData.title,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(
                                      _corrToDoData.isChecked ? 0.3 : 0.6)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // stepsのリスト
                  if (_corrToDoData.steps.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ReorderableColumn(
                        children: List<Widget>.generate(
                            _corrToDoData.steps.length,
                            (int indexOfThisStepInToDo) => Padding(
                                  key: Key(UniqueKey().toString()),
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 0, 2, 0),
                                  child: TLStepCard(
                                    toDoData: _corrToDoData,
                                    indexInToDo: indexOfThisStepInToDo,
                                  ),
                                )),
                        onReorder: (oldIndex, newIndex) {
                          final reOrderedToDo = _corrToDoData.steps[oldIndex];
                          _corrToDoData.steps.remove(reOrderedToDo);
                          _corrToDoData.steps.insert(newIndex, reOrderedToDo);
                          // toDosを保存する
                          _tlWorkspacesNotifier.updateSpecificTLWorkspace(
                            specificWorkspaceIndex: _currentTLWorkspaceNotifier
                                .currentTLWorkspaceIndex,
                            updatedWorkspace: _currentTLWorkspace,
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
