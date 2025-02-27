import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';

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
        extentRatio: 0.20,
        children: [
          // MARK: - Toggle Between Today and Whenever
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: cardColor,
            foregroundColor: iconColor,
            onPressed: (context) {
              ref
                  .read(tlAppStateProvider.notifier)
                  .updateState(TLToDoAction.toggleToDoTodayWhenever(
                    corrWorkspace: corrWorkspace,
                    corrToDo: corrToDo,
                  ));
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
        ],
      ),
      child: child,
    );
  }
}
