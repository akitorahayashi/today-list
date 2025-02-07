import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'tl_checkbox.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../../model/todo/tl_workspace.dart';
import '../../../model/todo/tl_step.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_todos_in_today_and_whenever.dart';
import '../../../service/tl_vibration.dart';

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
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    // others
    final TLWorkspace currentWorkspaceReference =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex].copyWith();
    // other
    final corrToDosReference =
        currentWorkspaceReference.categoryIDToToDos[corrCategoryID]!;
    final TLToDo corrToDoData =
        corrToDosReference.getToDos(ifInToday)[indexInToDos];
    final TLStep corrStepData = corrToDoData.steps[indexInSteps];

    return GestureDetector(
      onTap: () {
        // コピーしてデータを取得
        final TLToDo targetToDo = currentWorkspaceReference
            .categoryIDToToDos[corrCategoryID]!
            .getToDos(ifInToday)[indexInToDos];

        // 対象のStepを更新
        final TLStep updatedStep = targetToDo.steps[indexInSteps].copyWith(
          isChecked: !targetToDo.steps[indexInSteps].isChecked,
        );

        // 更新されたStepsを生成
        final List<TLStep> updatedSteps = List<TLStep>.from(targetToDo.steps);
        updatedSteps[indexInSteps] = updatedStep;

        // 更新されたToDoを生成
        TLToDo updatedToDo = targetToDo.copyWith(steps: updatedSteps);

        // Stepが全てチェックされた場合、ToDoの状態をチェック済みに変更
        if (updatedSteps.every((step) => step.isChecked)) {
          updatedToDo = updatedToDo.copyWith(isChecked: true);
        } else if (targetToDo.isChecked) {
          // ToDoがチェック済みの場合、未チェックに戻す
          updatedToDo = updatedToDo.copyWith(isChecked: false);
        }

        // 更新されたToDosリストを生成
        final List<TLToDo> updatedToDos = List<TLToDo>.from(
          currentWorkspaceReference.categoryIDToToDos[corrCategoryID]!
              .getToDos(ifInToday),
        );
        updatedToDos[indexInToDos] = updatedToDo;

        // 更新されたCategoryIDToToDosを生成
        final Map<String, TLToDosInTodayAndWhenever> updatedCategoryIDToToDos =
            Map<String, TLToDosInTodayAndWhenever>.from(
                currentWorkspaceReference.categoryIDToToDos);

        // 指定されたカテゴリのToDosリストを、条件に応じて更新し、Workspaceに反映する
        final TLToDosInTodayAndWhenever currentToDos =
            currentWorkspaceReference.categoryIDToToDos[corrCategoryID]!;
        updatedCategoryIDToToDos[corrCategoryID] = currentToDos.copyWith(
          toDosInToday: ifInToday ? updatedToDos : currentToDos.toDosInToday,
          toDosInWhenever:
              ifInToday ? currentToDos.toDosInWhenever : updatedToDos,
        );

        // 更新されたWorkspaceを生成
        final TLWorkspace updatedWorkspace = currentWorkspaceReference.copyWith(
          categoryIDToToDos: updatedCategoryIDToToDos,
        );

        // 更新されたWorkspaceを通知
        tlAppStateReducer
            .dispatchWorkspaceAction(TLWorkspaceAction.updateCurrentWorkspace(
          updatedWorkspace,
        ));

        // 振動と通知
        TLVibrationService.vibrate();
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: updatedStep.title,
          newCheckedState: updatedStep.isChecked,
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
