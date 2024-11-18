import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'icon_for_checkbox.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../model/tl_workspace.dart';
import '../../model/provider/current_tl_workspace_provider.dart';
import '../../model/provider/tl_workspaces_provider.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/external/tl_vibration.dart';

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
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    // other
    final corrToDos = currentTLWorkspace.categoryIDToToDos[corrCategoryID]!;
    final TLToDo corrToDoData = corrToDos[ifInToday][indexInToDos];
    final TLStep corrStepData = corrToDoData.steps[indexInSteps];

    return GestureDetector(
      // TODO 関数を渡して親のwidgetで処理する
      onTap: () {
        // stepのチェック状態を変更
        corrStepData.isChecked = !corrStepData.isChecked;
        // 主要のtodoがチェックされているときはチェック状態から変えたらそっちもかえる
        if (corrToDoData.isChecked) {
          corrToDoData.isChecked = false;
        }
        // stepが全てチェックされたら主要なほうもチェックする
        if (() {
          for (TLStep oneOfStep in corrToDoData.steps) {
            if (!oneOfStep.isChecked) {
              return false;
            }
          }
          return true;
        }()) {
          corrToDoData.isChecked = true;
        }

        // 更新されたToDoをワークスペースに反映
        tlWorkspacesNotifier.updateCurrentWorkspace(
            updatedWorkspace: currentTLWorkspace.copyWith());

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
