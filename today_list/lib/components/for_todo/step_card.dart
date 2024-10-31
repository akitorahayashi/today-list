import 'package:flutter/material.dart';
import '../../components/for_todo/icon_for_checkbox.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_step.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/external/tl_vibration.dart';
import '../../crud/for_todo/notify_todo_or_step_is_edited.dart';

class StepInToDoCard extends StatefulWidget {
  final TLToDo toDoData;
  final int indexOfThisStepInToDo;
  const StepInToDoCard({
    Key? key,
    required this.toDoData,
    required this.indexOfThisStepInToDo,
  }) : super(key: key);

  @override
  State<StepInToDoCard> createState() => _StepInToDoCardState();
}

class _StepInToDoCardState extends State<StepInToDoCard> {
  @override
  Widget build(BuildContext context) {
    final TLStep stepData = widget.toDoData.steps[widget.indexOfThisStepInToDo];
    return GestureDetector(
      onTap: () {
        // 主要のtodoがチェックされているときはチェック状態から変えたらそっちもかえる
        if (widget.toDoData.isChecked) {
          stepData.isChecked = !stepData.isChecked;
          widget.toDoData.isChecked = false;
        } else {
          // それ以外は単に切り替える
          stepData.isChecked = !stepData.isChecked;
        }
        // stepが全てチェックされたら主要なほうもチェックする
        if (() {
          for (TLStep oneOfStep in widget.toDoData.steps) {
            if (!oneOfStep.isChecked) {
              return false;
            }
          }
          return true;
        }()) {
          widget.toDoData.isChecked = true;
        }
        setState(() {});
        TLVibration.vibrate();
        notifyToDoOrStepIsEditted(
            context: context,
            newName: stepData.title,
            newCheckedState: stepData.isChecked,
            quickChangeToToday: null);
        TLWorkspace.saveSelectedWorkspace(
            selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex);
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
                  child: IconForCheckBox(isChecked: stepData.isChecked),
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
