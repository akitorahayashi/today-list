import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'tl_todo.dart';
import '../workspace/current_tl_workspace_provider.dart';
import '../workspace/tl_workspace.dart';
import '../workspace/tl_workspaces_provider.dart';

final edittingToDoProvider =
    StateNotifierProvider<EditingToDoNotifier, TLToDo?>((ref) {
  return EditingToDoNotifier(ref);
});

class EditingToDoNotifier extends StateNotifier<TLToDo?> {
  final Ref ref;

  EditingToDoNotifier(this.ref) : super(null);

  void initialize({required TLToDo? edittedToDo}) {
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

  Future<void> complete({
    required bool ifInToday,
    required String corrCategoryId,
  }) async {
    if (state == null) return;
    ;
    final _currentTLWorkspace = ref.read(currentTLWorkspaceProvider);

    final TLToDos _corrToDos = _currentTLWorkspace.toDos[corrCategoryId]!;
    _corrToDos[ifInToday].add(state!);

    await ref.read(tlWorkspacesProvider.notifier).updateSpecificTLWorkspace(
          specificWorkspaceIndex: ref
              .read(currentTLWorkspaceProvider.notifier)
              .currentTLWorkspaceIndex,
          updatedWorkspace: _currentTLWorkspace,
        );

    state = null;
  }
}
