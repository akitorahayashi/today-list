import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/view/component/slidable/slidable_for_todo_card.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_workspace_utils.dart';
import 'tl_checkbox.dart';
import 'tl_step_card.dart';

import 'package:reorderables/reorderables.dart';

class TLToDoCard extends ConsumerWidget {
  final bool ifInToday;
  final int indexOfThisToDoInToDos;
  final TLCategory bigCategoryOfThisToDo;
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
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );

    final TLCategory categoryOfThisToDo =
        smallCategoryOfThisToDo ?? bigCategoryOfThisToDo;
    final List<TLToDo> toDoArray = currentWorkspace
        .categoryIDToToDos[categoryOfThisToDo.id]!
        .getToDos(ifInToday);
    final TLToDo corrToDoData = toDoArray[indexOfThisToDoInToDos];

    // MARK: - Common Colors
    final panelColor = tlThemeData.canTapCardColor;
    final textColor =
        Colors.black.withOpacity(corrToDoData.isChecked ? 0.3 : 0.6);

    return GestureDetector(
      onTap: () => _toggleToDoCheckStatus(
          ref, context, currentWorkspace, categoryOfThisToDo),
      onLongPress: corrToDoData.isChecked ? () {} : null,
      child: Card(
        color: panelColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SlidableForToDoCard(
            isForModelCard: false,
            corrTLToDo: corrToDoData,
            indexOfThisToDoInToDos: indexOfThisToDoInToDos,
            ifInToday: ifInToday,
            bigCategoryID: bigCategoryOfThisToDo.id,
            smallCategoryID: smallCategoryOfThisToDo?.id,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildToDoContent(corrToDoData, textColor),
                if (corrToDoData.steps.isNotEmpty)
                  _buildStepsList(
                      ref, currentWorkspace, categoryOfThisToDo, corrToDoData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // MARK: - Build ToDo Content
  Widget _buildToDoContent(TLToDo corrToDoData, Color textColor) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          16, 18, 16, corrToDoData.steps.isNotEmpty ? 15 : 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
            child: Transform.scale(
              scale: 1.2,
              child: TLCheckBox(isChecked: corrToDoData.isChecked),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                corrToDoData.title,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MARK: - Build Steps List
  Widget _buildStepsList(WidgetRef ref, TLWorkspace currentWorkspace,
      TLCategory categoryOfThisToDo, TLToDo corrToDoData) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ReorderableColumn(
        children: List.generate(
          corrToDoData.steps.length,
          (int index) => Padding(
            key: ValueKey(corrToDoData.steps[index].id),
            padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
            child: TLStepCard(
              corrCategoryID: categoryOfThisToDo.id,
              ifInToday: ifInToday,
              indexInToDos: indexOfThisToDoInToDos,
              indexInSteps: index,
            ),
          ),
        ),
        onReorder: (oldIndex, newIndex) => _reorderSteps(
            ref, currentWorkspace, categoryOfThisToDo, oldIndex, newIndex),
      ),
    );
  }

  // MARK: - Toggle ToDo Check Status
  void _toggleToDoCheckStatus(WidgetRef ref, BuildContext context,
      TLWorkspace currentWorkspace, TLCategory categoryOfThisToDo) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    final List<TLToDo> toDoArray = currentWorkspace
        .categoryIDToToDos[categoryOfThisToDo.id]!
        .getToDos(ifInToday);
    final TLToDo corrToDoData = toDoArray[indexOfThisToDoInToDos];

    final newCheckedState = !corrToDoData.isChecked;
    final updatedSteps = corrToDoData.steps
        .map((step) => step.copyWith(isChecked: newCheckedState))
        .toList();
    final updatedToDo =
        corrToDoData.copyWith(isChecked: newCheckedState, steps: updatedSteps);

    final updatedToDos = List<TLToDo>.from(toDoArray)
      ..[indexOfThisToDoInToDos] = updatedToDo;
    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      categoryOfThisToDo.id: currentWorkspace
          .categoryIDToToDos[categoryOfThisToDo.id]!
          .copyWith(toDosInToday: ifInToday ? updatedToDos : []),
    };

    final updatedWorkspace = TLWorkspaceUtils.reorderWhenToggle(
      corrWorkspace: currentWorkspace.copyWith(
          categoryIDToToDos: updatedCategoryIDToToDos),
      categoryId: categoryOfThisToDo.id,
      ifInToday: ifInToday,
      indexOfThisToDoInToDos: indexOfThisToDoInToDos,
    );

    tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace));
    TLVibrationService.vibrate();
    NotifyTodoOrStepIsEditedSnackBar.show(
        context: context,
        newTitle: corrToDoData.title,
        newCheckedState: newCheckedState,
        quickChangeToToday: null);
  }

  // MARK: - Reorder Steps in ToDo
  void _reorderSteps(WidgetRef ref, TLWorkspace currentWorkspace,
      TLCategory categoryOfThisToDo, int oldIndex, int newIndex) {
    if (oldIndex == newIndex) return;
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    // `categoryIDToToDos` から対応する ToDo リストを取得
    final TLToDosInTodayAndWhenever toDosInCategory =
        currentWorkspace.categoryIDToToDos[categoryOfThisToDo.id]!;

    final List<TLToDo> toDoList =
        List<TLToDo>.from(toDosInCategory.getToDos(ifInToday));

    // 指定された ToDo を取得
    final TLToDo toDoData = toDoList[indexOfThisToDoInToDos];

    // steps を並び替え
    final List<TLStep> reorderedSteps = List<TLStep>.from(toDoData.steps);
    final TLStep movedStep = reorderedSteps.removeAt(oldIndex);
    reorderedSteps.insert(newIndex, movedStep);

    // 更新された ToDo を作成
    final TLToDo updatedToDo = toDoData.copyWith(steps: reorderedSteps);
    toDoList[indexOfThisToDoInToDos] = updatedToDo;

    // `categoryIDToToDos` を更新
    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      categoryOfThisToDo.id: toDosInCategory.copyWith(
        toDosInToday: ifInToday ? toDoList : toDosInCategory.toDosInToday,
        toDosInWhenever: ifInToday ? toDosInCategory.toDosInWhenever : toDoList,
      ),
    };

    // 新しい Workspace を作成
    final TLWorkspace updatedWorkspace = currentWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );

    // 更新された Workspace を適用
    tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace));
  }
}
