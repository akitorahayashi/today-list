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
  TLCategory selectedBigCategory;
  TLCategory? selectedSmallCategory = null;
  int? indexOfEditingToDo = null;

  EditingToDoNotifier(this.ref, this.selectedBigCategory) : super(null);

  void setInitialValue() {
    this.selectedBigCategory =
        ref.watch(currentTLWorkspaceProvider).bigCategories[0];
    this.ifInToday = true;
    indexOfEditingToDo = null;
    state = TLToDo(
      id: UniqueKey().toString(),
      title: '',
      steps: [],
      isChecked: false,
    );
  }

  void setEditedToDo({
    required bool ifInToday,
    required TLCategory selectedBigCategory,
    required TLCategory? selectedSmallCategory,
    required int indexOfEditingToDo,
  }) {
    this.ifInToday = ifInToday;
    this.selectedBigCategory = selectedBigCategory;
    this.selectedSmallCategory = selectedSmallCategory;
    this.indexOfEditingToDo = indexOfEditingToDo;
    final TLWorkspace _currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    final String _corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    state = _currentWorkspace.toDos[_corrCategoryID]![ifInToday]
        [indexOfEditingToDo];
  }

  void clearValue() {
    this.ifInToday = true;
    this.selectedBigCategory = TLCategory(id: noneID, title: "Error");
    this.selectedSmallCategory = null;
    this.indexOfEditingToDo = null;
    state = null;
  }

  Future<void> completeEditting() async {
    if (state == null) return;
    // provider
    final _currentTLWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);

    final String _corrCategoryID =
        selectedSmallCategory?.id ?? selectedBigCategory.id;
    final TLToDos _corrToDos = _currentTLWorkspace.toDos[_corrCategoryID]!;
    if (this.indexOfEditingToDo == null) {
      // add
      _corrToDos[this.ifInToday].add(state!);
    } else {
      // edit
      _corrToDos[this.ifInToday][indexOfEditingToDo!] = state!;
      this.indexOfEditingToDo = null;
    }
    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex:
              _currentTLWorkspaceNotifier.currentTLWorkspaceIndex,
          updatedWorkspace: _currentTLWorkspace,
        );

    state = null;
  }
}
