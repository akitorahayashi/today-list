import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
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
        _toggleStepCheckStatus(context, ref, corrWorkspace);
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

  // MARK: - Toggle Step Check Status
  void _toggleStepCheckStatus(
    BuildContext context,
    WidgetRef ref,
    TLWorkspace corrWorkspace,
  ) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    // Index
    final int indexInToDos = corrWorkspace
        .categoryIDToToDos[corrToDo.categoryID]!
        .getToDos(ifInToday)
        .indexOf(corrToDo);

    // Toggle Step's Checked Status
    final TLStep updatedStep =
        corrStep.copyWith(isChecked: !corrStep.isChecked);

    final List<TLStep> updatedSteps = corrToDo.steps
        .map((step) =>
            step == corrStep ? step.copyWith(isChecked: !step.isChecked) : step)
        .toList();

    // Update ToDo's Checked Status if all Steps are checked
    TLToDo updatedToDo = corrToDo.copyWith(steps: updatedSteps);
    if (updatedSteps.every((step) => step.isChecked)) {
      updatedToDo = updatedToDo.copyWith(isChecked: true);
    } else {
      updatedToDo = updatedToDo.copyWith(isChecked: false);
    }

    final TLToDosInTodayAndWhenever corrTLToDosInTodayAndWhenever =
        corrWorkspace.categoryIDToToDos[corrToDo.categoryID]!;

    // Update CategoryIDToToDos
    final List<TLToDo> updatedListOfToDo =
        List.from(corrTLToDosInTodayAndWhenever.getToDos(ifInToday));
    updatedListOfToDo[indexInToDos] = updatedToDo;

    final updatedCategoryIDToToDos = {
      ...corrWorkspace.categoryIDToToDos,
      corrToDo.categoryID: corrTLToDosInTodayAndWhenever.copyWith(
        toDosInToday: ifInToday
            ? updatedListOfToDo
            : corrTLToDosInTodayAndWhenever.toDosInToday,
        toDosInWhenever: ifInToday
            ? corrTLToDosInTodayAndWhenever.toDosInWhenever
            : updatedListOfToDo,
      ),
    };

    // Update Workspace
    final updatedWorkspace = corrWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );

    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCorrWorkspace(updatedWorkspace),
    );

    // Vibration & Notification
    TLVibrationService.vibrate();
    NotifyTodoOrStepIsEditedSnackBar.show(
      context: context,
      newTitle: updatedStep.content,
      newCheckedState: updatedStep.isChecked,
      quickChangeToToday: null,
    );
  }
}
