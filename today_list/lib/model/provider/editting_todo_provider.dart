import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_todo.dart';
import './current_tl_workspace_provider.dart';
import './tl_workspaces_provider.dart';

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, TLToDo?>((ref) {
  return EditingToDoNotifier(ref);
});

class EditingToDoNotifier extends StateNotifier<TLToDo?> {
  final Ref ref;
  bool ifInToday = true;
  String corrCategoryId = '';
  int? indexOfEditingToDo = null;

  EditingToDoNotifier(this.ref) : super(null);

  void setInitialValue() {
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
    required int indexOfEditingToDo,
    required TLToDo edittedToDo,
  }) {
    this.ifInToday = ifInToday;
    this.indexOfEditingToDo = indexOfEditingToDo;
    state = edittedToDo;
  }

  void clearValue() {
    this.ifInToday = true;
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

    final TLToDos _corrToDos = _currentTLWorkspace.toDos[corrCategoryId]!;
    if (this.indexOfEditingToDo == null) {
      // add
      _corrToDos[this.ifInToday].add(state!);
    } else {
      // edit
      _corrToDos[ifInToday][indexOfEditingToDo!] = state!;
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
