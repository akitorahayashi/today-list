import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import 'tl_checkbox.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../../model/todo/tl_workspace.dart';
import '../../../model/todo/tl_step.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/external/tl_vibration.dart';

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
    // provider
    final TLWorkspacesState tlWorkspacesState =
        ref.watch(tlWorkspacesStateProvider);
    final TLWorkspace currentTLWorkspace = tlWorkspacesState.currentWorkspace;
    // notifier
    final TLWorkspacesStateNotifier tlWorkspacesStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    // other
    final corrToDos = currentTLWorkspace.categoryIDToToDos[corrCategoryID]!;
    final TLToDo corrToDoData = corrToDos[ifInToday][indexInToDos];
    final TLStep corrStepData = corrToDoData.steps[indexInSteps];

    return GestureDetector(
      onTap: () {
        final copiedCurrentTLWorkspace = currentTLWorkspace.copyWith();
        final copiedCorrToDoData = copiedCurrentTLWorkspace
            .categoryIDToToDos[corrCategoryID]![ifInToday][indexInToDos];
        final copiedCorrStepData = copiedCorrToDoData.steps[indexInSteps];
        // stepのチェック状態を変更
        copiedCorrStepData.isChecked = !copiedCorrStepData.isChecked;
        // 主要のtodoがチェックされているときはチェック状態から変えたらそっちもかえる
        if (copiedCorrToDoData.isChecked) {
          copiedCorrToDoData.isChecked = false;
        }
        // stepが全てチェックされたら主要なほうもチェックする
        if (() {
          for (TLStep oneOfStep in copiedCorrToDoData.steps) {
            if (!oneOfStep.isChecked) {
              return false;
            }
          }
          return true;
        }()) {
          copiedCorrToDoData.isChecked = true;
        }

        // 更新されたToDoをワークスペースに反映
        tlWorkspacesStateNotifier.updateCurrentWorkspace(
            updatedCurrentWorkspace: copiedCurrentTLWorkspace);

        TLVibration.vibrate();
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: corrStepData.title,
          newCheckedState: corrStepData.isChecked,
          quickChangeToToday: null,
        );
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            children: [
              // 左側のチェックボックス
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                child: Transform.scale(
                  scale: 1.2,
                  child: TLCheckBox(isChecked: corrStepData.isChecked),
                ),
              ),
              // stepのタイトル
              Expanded(
                child: Text(corrStepData.title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                            .withOpacity(corrStepData.isChecked ? 0.3 : 0.6))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
