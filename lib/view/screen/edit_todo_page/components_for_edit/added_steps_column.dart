import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/model/todo/tl_step.dart';
import '../../../component/todo_card/tl_checkbox.dart';
import '../../../../redux/store/editing_provider/editing_todo_provider.dart';

class AddedStepsColumn extends ConsumerWidget {
  const AddedStepsColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final EditingTodo editingToDo = ref.watch(editingToDoProvider);
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: List<Widget>.generate(editingToDo.steps.length, (i) {
          return Padding(
            key: ValueKey(editingToDo.steps[i].id),
            padding: const EdgeInsets.only(left: 37.0, top: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TLCheckBox(
                    isChecked: false,
                    iconColor: Colors.black.withOpacity(0.35),
                    iconSize: 23,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                      onTap: () {
                        EditingTodo.stepTitleInputController?.text =
                            editingToDo.steps[i].title;
                        editingToDoNotifier.updateEditingTodo(
                            indexOfEditingStep: i);
                        TLVibrationService.vibrate();
                      },
                      child: Text(
                        editingToDo.steps[i].title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withOpacity(0.55)),
                      )),
                ),
                // step を消す
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TextButton(
                    onPressed: () {
                      final copiedSteps = List<TLStep>.from(editingToDo.steps);
                      copiedSteps.removeAt(i);
                      editingToDoNotifier.updateEditingTodo(
                        steps: copiedSteps,
                        smallCategoryID: editingToDo.smallCategoryID,
                        indexOfEditingToDo: editingToDo.indexOfEditingToDo,
                        indexOfEditingStep: null,
                      );
                      editingToDo.indexOfEditingStep = null;
                      TLVibrationService.vibrate();
                    },
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 9.0),
                      child: Icon(
                        Icons.remove,
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
