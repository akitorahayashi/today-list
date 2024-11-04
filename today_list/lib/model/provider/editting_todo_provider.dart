import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/tl_workspace.dart';
import 'package:today_list/model/todo/tl_category.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_todo.dart';
import './current_tl_workspace_provider.dart';
import './tl_workspaces_provider.dart';

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, TLToDo>((ref) {
  return EditingToDoNotifier(ref, TLCategory(id: noneID, title: "Error"));
});

class EditingToDoNotifier extends StateNotifier<TLToDo> {
  final Ref ref;
  bool ifInToday = true;
  late TextEditingController toDoTitleInputController;
  late TextEditingController stepTitleInputController;
  TLCategory selectedBigCategory;
  TLCategory? selectedSmallCategory;
  int? indexOfEditingToDo;

  EditingToDoNotifier(this.ref, this.selectedBigCategory)
      : super(TLToDo(
          id: UniqueKey().toString(),
          title: 'Error',
          steps: [],
          isChecked: false,
        ));

  void setInitialValue() {
    ifInToday = true;
    toDoTitleInputController = TextEditingController();
    stepTitleInputController = TextEditingController();
    selectedBigCategory =
        ref.watch(currentTLWorkspaceProvider).bigCategories[0];
    state = TLToDo.getDefaultToDo();
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
      corrToDos[ifInToday].add(state.copyWith());
    } else {
      // edit
      corrToDos[ifInToday][indexOfEditingToDo!] = state.copyWith();
      indexOfEditingToDo = null;
    }
    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex:
              currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
          updatedWorkspace: currentTLWorkspace,
        );
    // 入力事項の初期化
    state = TLToDo.getDefaultToDo();
    toDoTitleInputController.clear();
    stepTitleInputController.clear();
  }

  void disposeValue() {
    ifInToday = true;
    toDoTitleInputController.dispose();
    stepTitleInputController.dispose();
    selectedBigCategory;
    selectedSmallCategory = null;
    indexOfEditingToDo = null;
    state = TLToDo.getDefaultToDo();
  }
}
