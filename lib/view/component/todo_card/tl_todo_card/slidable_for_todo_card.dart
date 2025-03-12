import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/action/todo_action.dart';
import 'package:today_list/flux/dispatcher/todo_dispatcher.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/view/page/home_page/edit_todo_sheet/edit_todo_sheet.dart';

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
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    // MARK: - Colors
    final cardColor = tlThemeConfig.canTapCardColor;
    final iconColor = tlThemeConfig.accentColor;

    return Slidable(
      enabled: !corrToDo.isChecked,

      // MARK: - Edit / Move ToDo
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.40,
        children: [
          // MARK: - Toggle Between Today and Whenever
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: cardColor,
            foregroundColor: iconColor,
            onPressed: (context) {
              // Fluxパターンを使用してToDoの今日/いつかを切り替える
              TodoDispatcher.dispatch(
                ref,
                TodoAction.toggleTodoTodayWhenever(
                  workspace: corrWorkspace,
                  todo: corrToDo,
                ),
              );

              NotifyTodoOrStepIsEditedSnackBar.show(
                context: context,
                newTitle: corrToDo.content,
                newCheckedState: corrToDo.isChecked,
                isToDoCard: true,
                quickChangeToToday: !corrToDo.isInToday,
              );
            },
            icon: corrToDo.isInToday ? Icons.schedule : Icons.light_mode,
          ),
          // MARK: - Edit ToDo
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: cardColor,
            foregroundColor: iconColor,
            onPressed: (context) {
              _showEditToDoSheet(context, ref);
            },
            icon: Icons.edit,
          ),
        ],
      ),
      child: child,
    );
  }

  // MARK: - ToDoの編集シートを表示
  void _showEditToDoSheet(BuildContext context, WidgetRef ref) {
    // モーダルボトムシートを表示（編集用）
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => EditToDoSheet(
            workspaceID: corrWorkspace.id,
            todoToEdit: corrToDo, // 編集対象のToDoを渡す
            onComplete: () {
              Navigator.pop(context);
            },
          ),
    );
  }
}
