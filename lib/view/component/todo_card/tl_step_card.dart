import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'tl_checkbox.dart';

class TLStepCard extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final TLToDo corrToDo;
  final TLStep corrStep;

  const TLStepCard({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.corrToDo,
    required this.corrStep,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    // MARK: - Common Colors
    final cardColor = tlThemeConfig.whiteBasedColor;
    final titleColor = Colors.black.withOpacity(corrStep.isChecked ? 0.3 : 0.6);

    return GestureDetector(
      onTap: () {
        ref.read(tlAppStateProvider.notifier).updateState(
              TLToDoAction.toggleStepCheckStatus(
                corrWorkspace: corrWorkspace,
                corrToDo: corrToDo,
                corrStep: corrStep,
              ),
            );

        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: corrStep.content,
          newCheckedState: !corrStep.isChecked,
          isToDoCard: false,
          quickChangeToToday: null,
        );
      },
      child: Card(
        color: cardColor,
        elevation: 1.2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // MARK: - Checkbox
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                child: Transform.scale(
                  scale: 1.2,
                  child: TLCheckBox(isChecked: corrStep.isChecked),
                ),
              ),

              // MARK: - Step Title
              Expanded(
                child: Text(
                  corrStep.content,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
