import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_todo.dart';
import './current_tl_workspace_provider.dart';
import './tl_workspaces_provider.dart';

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, TLToDo?>((ref) {
  return EditingToDoNotifier(ref, TLCategory(id: noneID, title: "Error"));
});

class EditingToDoNotifier extends StateNotifier<TLToDo?> {
  final Ref ref;
  bool ifInToday = true;
  late TextEditingController toDoTitleInputController;
  late TextEditingController stepTitleInputController;
  TLCategory selectedBigCategory;
  TLCategory? selectedSmallCategory;
  int? indexOfEditingToDo;

  EditingToDoNotifier(this.ref, this.selectedBigCategory) : super(null);

  void setInitialValue() {
    ifInToday = true;
    toDoTitleInputController = TextEditingController();
    stepTitleInputController = TextEditingController();
    selectedBigCategory =
        ref.watch(currentTLWorkspaceProvider).bigCategories[0];
    state = TLToDo(
      id: UniqueKey().toString(),
      title: '',
      steps: [],
      isChecked: false,
    );
    indexOfEditingToDo = null;
  }

  void setEditedToDo({
    required bool ifInToday,
    required TLCategory selectedBigCategory,
    required TLCategory? selectedSmallCategory,
    required int indexOfEditingToDo,
  }) {
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    final String corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    final TLToDo edittedToDo =
        currentWorkspace.toDos[corrCategoryID]![ifInToday][indexOfEditingToDo];
    // setValues
    this.ifInToday = ifInToday;
    toDoTitleInputController = TextEditingController()
      ..text = edittedToDo.title;
    stepTitleInputController = TextEditingController();
    this.selectedBigCategory = selectedBigCategory;
    this.selectedSmallCategory = selectedSmallCategory;
    this.indexOfEditingToDo = indexOfEditingToDo;
    state = edittedToDo;
  }

  Future<void> completeEditting() async {
    if (state == null) return;
    // provider
    final currentTLWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);

    final String corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    final TLToDos corrToDos = currentTLWorkspace.toDos[corrCategoryID]!;
    if (indexOfEditingToDo == null) {
      // add
      corrToDos[ifInToday].add(state!);
    } else {
      // edit
      corrToDos[ifInToday][indexOfEditingToDo!] = state!;
      indexOfEditingToDo = null;
    }
    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex:
              currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
          updatedWorkspace: currentTLWorkspace,
        );

    state = null;
  }

  void disposeValue() {
    ifInToday = true;
    toDoTitleInputController.dispose();
    stepTitleInputController.dispose();
    selectedBigCategory;
    selectedSmallCategory = null;
    indexOfEditingToDo = null;
    state = null;
  }
}
