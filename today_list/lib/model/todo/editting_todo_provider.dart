import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'tl_todo.dart';
import '../workspace/current_tl_workspace_provider.dart';
import '../workspace/tl_workspaces_provider.dart';

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, TLToDo?>((ref) {
  return EditingToDoNotifier(ref, null);
});

class EditingToDoNotifier extends StateNotifier<TLToDo?> {
  final Ref ref;
  int? indexOfEditingToDo;

  EditingToDoNotifier(this.ref, this.indexOfEditingToDo) : super(null);

  void startToEdit({required TLToDo? edittedToDo}) {
    if (edittedToDo != null) {
      state = edittedToDo;
    } else {
      state = TLToDo(
        id: UniqueKey().toString(),
        title: '',
        steps: [],
        isChecked: false,
      );
    }
  }

  Future<void> completeEditting({
    required bool ifInToday,
    required String corrCategoryId,
  }) async {
    if (state == null) return;
    // provider
    final _currentTLWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);

    final TLToDos _corrToDos = _currentTLWorkspace.toDos[corrCategoryId]!;
    if (this.indexOfEditingToDo == null) {
      // add
      _corrToDos[ifInToday].add(state!);
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
