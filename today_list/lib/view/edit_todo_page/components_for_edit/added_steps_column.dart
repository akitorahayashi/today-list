import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import '../../../components/todo_card/icon_for_checkbox.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/provider/editting_todo_provider.dart';
import '../../../model/provider/tl_workspaces_provider.dart';
import '../../../model/tl_workspace.dart';
import '../../../model/todo/tl_todo.dart';

import 'package:reorderables/reorderables.dart';

class AddedStepsColumn extends ConsumerWidget {
  const AddedStepsColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider
    final EdittingTodo edittingToDo = ref.watch(edittingToDoProvider);
    final TLWorkspace currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final EditingToDoNotifier edittingToDoNotifier =
        ref.read(edittingToDoProvider.notifier);
    final CurrentTLWorkspaceNotifier currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ReorderableColumn(
        children: List<Widget>.generate(edittingToDo.steps.length, (i) {
          return Padding(
            key: ValueKey(edittingToDo.steps[i].id),
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
                        edittingToDo.stepTitleInputController?.text =
                            edittingToDo.steps[i].title;
                        edittingToDo.indexOfEditingStep = i;
                        TLVibration.vibrate();
                      },
                      child: Text(
                        edittingToDo.steps[i].title,
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
                      edittingToDo.steps.removeAt(i);
                      edittingToDo.indexOfEditingStep = null;
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
          final reOrderedToDo = edittingToDo.removeAt(oldIndex);
          if (newIndex > oldIndex) newIndex--;
          stepList.insert(newIndex, reOrderedToDo);
          tlWorkspacesNotifier.updateSpecificTLWorkspace(
              specificWorkspaceIndex:
                  currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
              updatedWorkspace: currentTLWorkspace);
        },
      ),
    );
  }
}
