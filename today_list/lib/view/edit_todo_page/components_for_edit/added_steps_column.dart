import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import '../../../components/todo_card/icon_for_checkbox.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/provider/editing_provider/editing_todo_provider.dart';
import '../../../model/provider/tl_workspaces_provider.dart';
import '../../../model/tl_workspace.dart';

import 'package:reorderables/reorderables.dart';

class AddedStepsColumn extends ConsumerWidget {
  const AddedStepsColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final EditingTodo editingToDo = ref.watch(editingToDoProvider);
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ReorderableColumn(
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
                        editingToDo.indexOfEditingStep = i;
                        TLVibration.vibrate();
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
                      editingToDo.steps.removeAt(i);
                      editingToDo.indexOfEditingStep = null;
                      TLVibration.vibrate();
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
        onReorder: (oldIndex, newIndex) {
          if (oldIndex == newIndex) return;
          final reOrderedToDo = editingToDo.steps.removeAt(oldIndex);
          if (newIndex > oldIndex) newIndex--;
          editingToDo.steps.insert(newIndex, reOrderedToDo);
          editingToDoNotifier.updateEdittingTodo(steps: editingToDo.steps);
          tlWorkspacesNotifier.updateCurrentWorkspace(
              updatedWorkspace: currentTLWorkspace);
        },
      ),
    );
  }
}
