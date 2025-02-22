import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/view/component/slidable/slidable_for_todo_card.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_workspace_utils.dart';
import 'tl_checkbox.dart';
import 'tl_step_card.dart';
import 'dart:ui';

import 'package:reorderables/reorderables.dart';

class TLToDoCard extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final TLToDo corrToDo;

  const TLToDoCard({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.corrToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - Colors
    final panelColor = tlThemeData.canTapCardColor;
    final textColor = Colors.black.withOpacity(corrToDo.isChecked ? 0.3 : 0.6);

    return GestureDetector(
      onTap: () => _toggleToDoCheckStatus(
          ref, context, ifInToday, corrWorkspace, corrToDo),
      onLongPress: corrToDo.isChecked ? () {} : null,
      child: Card(
        color: panelColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SlidableForToDoCard(
              ifInToday: ifInToday,
              corrWorkspace: corrWorkspace,
              corrToDo: corrToDo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildToDoContent(corrToDo, textColor),
                  if (corrToDo.steps.isNotEmpty)
                    _buildStepsList(ref, corrWorkspace, corrToDo),
                ],
              ),
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
                corrToDoData.content,
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
  Widget _buildStepsList(
      WidgetRef ref, TLWorkspace corrWorkspace, TLToDo corrToDo) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ReorderableColumn(
        children: List.generate(
          corrToDo.steps.length,
          (int index) => Padding(
            key: ValueKey(corrToDo.steps[index].id),
            padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
            child: TLStepCard(
              ifInToday: ifInToday,
              corrWorkspace: corrWorkspace,
              corrToDo: corrToDo,
              corrStep: corrToDo.steps[index],
            ),
          ),
        ),
        onReorder: (oldIndex, newIndex) =>
            _reorderSteps(ref, corrWorkspace, corrToDo, oldIndex, newIndex),
      ),
    );
  }

  // MARK: - Toggle ToDo Check Status
  void _toggleToDoCheckStatus(
    WidgetRef ref,
    BuildContext context,
    bool ifInToday,
    TLWorkspace currentWorkspace,
    TLToDo corrToDo,
  ) {
    // チェック状態を反転
    final newCheckedState = !corrToDo.isChecked;

    // ステップのチェック状態を更新
    final updatedSteps = corrToDo.steps
        .map((step) => step.copyWith(isChecked: newCheckedState))
        .toList();

    // 更新後の ToDo データ
    final TLToDo updatedToDo =
        corrToDo.copyWith(isChecked: newCheckedState, steps: updatedSteps);

    // 該当する位置に入れる
    final List<TLToDo> corrListOfToDo = corrWorkspace
        .categoryIDToToDos[corrToDo.categoryID]!
        .getToDos(ifInToday);
    final indexOfThisToDoInToDos = corrListOfToDo.indexOf(corrToDo);
    final updatedCorrListOfToDo = List<TLToDo>.from(corrListOfToDo)
      ..[indexOfThisToDoInToDos] = updatedToDo;

    // 所属するToDoの配列の中での並び替え
    final reorderedCorrListOfToDo = TLWorkspaceUtils.reorderWhenToggle(
      toDoArrayOfThisToDo: updatedCorrListOfToDo,
      indexOfThisToDoInToDos: indexOfThisToDoInToDos,
    );

    // 変更があったToDoの変更を反映させる
    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      corrToDo.categoryID:
          currentWorkspace.categoryIDToToDos[corrToDo.categoryID]!.copyWith(
        toDosInToday: ifInToday ? reorderedCorrListOfToDo : corrListOfToDo,
        toDosInWhenever: ifInToday ? corrListOfToDo : reorderedCorrListOfToDo,
      ),
    };

    // アプリの状態を更新
    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
            TLWorkspaceAction.updateCorrWorkspace(corrWorkspace.copyWith(
          categoryIDToToDos: updatedCategoryIDToToDos,
        )));

    // バイブレーション
    TLVibrationService.vibrate();

    // スナックバーを表示
    NotifyTodoOrStepIsEditedSnackBar.show(
      context: context,
      newTitle: corrToDo.content,
      newCheckedState: newCheckedState,
      quickChangeToToday: null,
    );
  }

  // MARK: - Reorder Steps in ToDo
  void _reorderSteps(
    WidgetRef ref,
    TLWorkspace currentWorkspace,
    TLToDo corrToDo,
    int oldIndex,
    int newIndex,
  ) {
    if (oldIndex == newIndex) return;

    // 現在の ToDo リストを取得
    final toDosInCategory =
        currentWorkspace.categoryIDToToDos[corrToDo.categoryID]!;
    final toDoList = toDosInCategory.getToDos(ifInToday);
    final indexOfThisToDoInToDos = toDoList.indexOf(corrToDo);

    // 操作対象の ToDo を取得
    final toDoData = toDoList[indexOfThisToDoInToDos];

    // ステップの並び順を更新（元のリストを変更せずに新しいリストを作成）
    final reorderedSteps = [
      ...toDoData.steps.sublist(0, oldIndex),
      ...toDoData.steps.sublist(oldIndex + 1, newIndex),
      toDoData.steps[oldIndex],
      ...toDoData.steps.sublist(newIndex),
    ];

    // 更新後の ToDo データを作成
    final updatedToDo = toDoData.copyWith(steps: reorderedSteps);

    // 更新後の ToDo リストを作成
    final updatedToDoList = toDoList
        .map(
          (todo) => todo == corrToDo ? updatedToDo : todo,
        )
        .toList();

    // 更新後の ToDosInCategory を作成
    final updatedToDosInCategory = toDosInCategory.copyWith(
      toDosInToday: ifInToday ? updatedToDoList : toDosInCategory.toDosInToday,
      toDosInWhenever:
          ifInToday ? toDosInCategory.toDosInWhenever : updatedToDoList,
    );

    // 更新後のカテゴリIDマップを作成
    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      corrToDo.categoryID: updatedToDosInCategory,
    };

    // アップデートした Workspace を作成
    final updatedWorkspace = currentWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );

    // 状態を更新
    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
        TLWorkspaceAction.updateCorrWorkspace(updatedWorkspace));
  }
}
