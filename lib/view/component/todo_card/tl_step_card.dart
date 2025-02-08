import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  final String corrCategoryID;
  final bool ifInToday;
  final int indexInToDos;
  final int indexInSteps;

  const TLStepCard({
    super.key,
    required this.corrCategoryID,
    required this.ifInToday,
    required this.indexInToDos,
    required this.indexInSteps,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWorkspace = ref.watch(
      tlAppStateProvider
          .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]),
    );

    final corrToDosReference =
        currentWorkspace.categoryIDToToDos[corrCategoryID]!;
    final TLToDo corrToDoData =
        corrToDosReference.getToDos(ifInToday)[indexInToDos];
    final TLStep corrStepData = corrToDoData.steps[indexInSteps];

    // MARK: - Common Colors
    const cardColor = Colors.white;
    final titleColor =
        Colors.black.withOpacity(corrStepData.isChecked ? 0.3 : 0.6);

    return GestureDetector(
      onTap: () => _toggleStepCheckStatus(
          context, ref, currentWorkspace, corrToDosReference),
      child: Card(
        color: cardColor,
        elevation: 2,
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
                  child: TLCheckBox(isChecked: corrStepData.isChecked),
                ),
              ),

              // MARK: - Step Title
              Expanded(
                child: Text(
                  corrStepData.title,
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
    TLWorkspace currentWorkspace,
    TLToDosInTodayAndWhenever corrToDosReference,
  ) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    // Copy target ToDo
    final TLToDo targetToDo =
        corrToDosReference.getToDos(ifInToday)[indexInToDos];

    // Toggle Step's Checked Status
    final TLStep updatedStep = targetToDo.steps[indexInSteps].copyWith(
      isChecked: !targetToDo.steps[indexInSteps].isChecked,
    );

    // Update Steps List
    final List<TLStep> updatedSteps = List.from(targetToDo.steps);
    updatedSteps[indexInSteps] = updatedStep;

    // Update ToDo's Checked Status if all Steps are checked
    TLToDo updatedToDo = targetToDo.copyWith(steps: updatedSteps);
    if (updatedSteps.every((step) => step.isChecked)) {
      updatedToDo = updatedToDo.copyWith(isChecked: true);
    } else if (targetToDo.isChecked) {
      updatedToDo = updatedToDo.copyWith(isChecked: false);
    }

    // MARK: - Update CategoryIDToToDos
    final List<TLToDo> updatedToDos =
        List.from(corrToDosReference.getToDos(ifInToday));
    updatedToDos[indexInToDos] = updatedToDo;

    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      corrCategoryID: corrToDosReference.copyWith(
        toDosInToday:
            ifInToday ? updatedToDos : corrToDosReference.toDosInToday,
        toDosInWhenever:
            ifInToday ? corrToDosReference.toDosInWhenever : updatedToDos,
      ),
    };

    // Update Workspace
    final updatedWorkspace = currentWorkspace.copyWith(
      categoryIDToToDos: updatedCategoryIDToToDos,
    );

    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace),
    );

    // Vibration & Notification
    TLVibrationService.vibrate();
    NotifyTodoOrStepIsEditedSnackBar.show(
      context: context,
      newTitle: updatedStep.title,
      newCheckedState: updatedStep.isChecked,
      quickChangeToToday: null,
    );
  }
}
