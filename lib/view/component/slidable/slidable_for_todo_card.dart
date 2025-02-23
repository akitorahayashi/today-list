import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends ConsumerWidget {
  final TLWorkspace corrWorkspace;
  final TLToDo corrToDo;
  final Widget child;

  const SlidableForToDoCard({
    super.key,
    required this.corrWorkspace,
    required this.corrToDo,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - Colors
    final backgroundColor = tlThemeData.canTapCardColor;
    final foregroundColor = tlThemeData.accentColor;

    return Slidable(
      enabled: !corrToDo.isChecked,

      // MARK: - Delete ToDo
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.15,
        children: [
          SlidableAction(
            autoClose: true,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            onPressed: (context) => ref
                .read(tlAppStateProvider.notifier)
                .dispatchToDoAction(TLToDoAction.deleteToDo(
                  corrWorkspace: corrWorkspace,
                  corrToDo: corrToDo,
                )),
            icon: Icons.remove,
          ),
        ],
      ),

      // MARK: - Edit / Move ToDo
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.4,
        children: [
          // MARK: - Toggle Between Today and Whenever
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            onPressed: (context) =>
                _toggleToDoTodayWhenever(ref, context, corrWorkspace, corrToDo),
            icon: corrToDo.isInToday ? Icons.schedule : Icons.light_mode,
          ),
        ],
      ),
      child: child,
    );
  }

  // MARK: - Toggle ToDo Between Today and Whenever
  void _toggleToDoTodayWhenever(
    WidgetRef ref,
    BuildContext context,
    TLWorkspace corrWorkspace,
    TLToDo corrToDo,
  ) {
    final TLToDosInTodayAndWhenever toDosInCategory =
        corrWorkspace.categoryIDToToDos[corrToDo.categoryID]!;

    // 現在のリストと移動先のリストを取得
    final currentList = toDosInCategory.getToDos(corrToDo.isInToday);
    final anotherList = toDosInCategory.getToDos(!corrToDo.isInToday);

    // 現在のリストから対象の ToDo を除外
    final updatedCurrentList =
        currentList.where((todo) => todo != corrToDo).toList();

    // 移動先のリストに対象の ToDo を先頭に追加
    final updatedOtherList = [corrToDo, ...anotherList];

    // ToDos のデータを更新
    final updatedToDosInCategory = toDosInCategory.copyWith(
      toDosInToday: corrToDo.isInToday ? updatedCurrentList : updatedOtherList,
      toDosInWhenever:
          corrToDo.isInToday ? updatedOtherList : updatedCurrentList,
    );

    // Workspace のデータを更新
    final updatedCategoryIDToToDos = {
      ...corrWorkspace.categoryIDToToDos,
      corrToDo.categoryID: updatedToDosInCategory,
    };

    // Workspace の状態を更新
    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
          TLWorkspaceAction.updateCorrWorkspace(
            corrWorkspace.copyWith(categoryIDToToDos: updatedCategoryIDToToDos),
          ),
        );

    // バイブレーション & スナックバー表示
    TLVibrationService.vibrate();
    NotifyTodoOrStepIsEditedSnackBar.show(
      context: context,
      newTitle: corrToDo.content,
      newCheckedState: corrToDo.isChecked,
      quickChangeToToday: !corrToDo.isInToday,
    );
  }
}
