import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/todo_card/icon_for_checkbox.dart';
import 'package:today_list/components/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/model/tl_workspace.dart';
import '../../model/provider/current_tl_workspace_provider.dart';
import '../../model/provider/tl_workspaces_provider.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/external/tl_vibration.dart';

class TLStepCard extends ConsumerWidget {
  final TLToDo toDoData;
  final int indexInToDo;

  const TLStepCard({
    super.key,
    required this.toDoData,
    required this.indexInToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final TLWorkspace _currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier _currentTLWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
    // other
    final int _currentTLWorkspaceIndex =
        _currentTLWorkspaceNotifier.currentWorkspaceIndex;
    final TLStep stepData = toDoData.steps[indexInToDo];

    return GestureDetector(
      onTap: () {
        // stepのチェック状態を変更
        stepData.isChecked = !stepData.isChecked;
        // 主要のtodoがチェックされているときはチェック状態から変えたらそっちもかえる
        if (toDoData.isChecked) {
          toDoData.isChecked = false;
        }
        // stepが全てチェックされたら主要なほうもチェックする
        if (() {
          for (TLStep oneOfStep in toDoData.steps) {
            if (!oneOfStep.isChecked) {
              return false;
            }
          }
          return true;
        }()) {
          toDoData.isChecked = true;
        }

        // 更新されたToDoをワークスペースに反映
        _tlWorkspacesNotifier.updateCurrentWorkspace(
            updatedWorkspace: _currentTLWorkspace);

        TLVibration.vibrate();
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: stepData.title,
          newCheckedState: stepData.isChecked,
          quickChangeToToday: null,
        );
      },
      child: Card(
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
                  child: TLCheckBox(isChecked: stepData.isChecked),
                ),
              ),
              // stepのタイトル
              Expanded(
                child: Text(stepData.title,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                            .withOpacity(stepData.isChecked ? 0.3 : 0.6))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'icon_for_checkbox.dart';
// import '../../model/todo/tl_todo.dart';
// import '../../model/todo/tl_step.dart';
// import '../../model/workspace/tl_workspace.dart';
// import '../../model/external/tl_vibration.dart';
// import '../../dialogs/notify_todo_or_step_is_edited.dart';

// class StepInToDoCard extends StatefulWidget {
//   final TLToDo toDoData;
//   final int indexOfThisStepInToDo;
//     Key? key,
//   const StepInToDoCard({
//     required this.toDoData,
//     required this.indexOfThisStepInToDo,
//   }) : super(key: key);

//   @override
//   State<StepInToDoCard> createState() => _StepInToDoCardState();
// }

// class _StepInToDoCardState extends State<StepInToDoCard> {
//   @override
//   Widget build(BuildContext context) {
//     final TLStep stepData = widget.toDoData.steps[widget.indexOfThisStepInToDo];
//     return GestureDetector(
//       onTap: () {
//         // 主要のtodoがチェックされているときはチェック状態から変えたらそっちもかえる
//         if (widget.toDoData.isChecked) {
//           stepData.isChecked = !stepData.isChecked;
//           widget.toDoData.isChecked = false;
//         } else {
//           // それ以外は単に切り替える
//           stepData.isChecked = !stepData.isChecked;
//         }
//         // stepが全てチェックされたら主要なほうもチェックする
//         if (() {
//           for (TLStep oneOfStep in widget.toDoData.steps) {
//             if (!oneOfStep.isChecked) {
//               return false;
//             }
//           }
//           return true;
//         }()) {
//           widget.toDoData.isChecked = true;
//         }
//         setState(() {});
//         TLVibration.vibrate();
//         notifyToDoOrStepIsEditted(
//             context: context,
//             newName: stepData.title,
//             newCheckedState: stepData.isChecked,
//             quickChangeToToday: null);
//         TLWorkspace.saveSelectedWorkspace(
//             selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex);
//       },
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
//           child: Row(
//             children: [
//               // 左側のチェックボックス
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
//                 child: Transform.scale(
//                   scale: 1.2,
//                   child: IconForCheckBox(isChecked: stepData.isChecked),
//                 ),
//               ),
//               // stepのタイトル
//               Expanded(
//                 child: Text(stepData.title,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black
//                             .withOpacity(stepData.isChecked ? 0.3 : 0.6))),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
