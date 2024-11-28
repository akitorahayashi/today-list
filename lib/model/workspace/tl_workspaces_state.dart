import 'dart:convert';

import 'package:today_list/model/external/tl_pref.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/workspace/tl_workspace.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TLWorkspacesState {
  final List<TLWorkspace> workspaces;
  final int currentWorkspaceIndex;

  TLWorkspacesState({
    required this.workspaces,
    required this.currentWorkspaceIndex,
  });

  TLWorkspace get currentWorkspace => workspaces[currentWorkspaceIndex];

  TLWorkspacesState copyWith({
    List<TLWorkspace>? workspaces,
    int? currentWorkspaceIndex,
  }) {
    return TLWorkspacesState(
      workspaces: workspaces ?? this.workspaces,
      currentWorkspaceIndex:
          currentWorkspaceIndex ?? this.currentWorkspaceIndex,
    );
  }
}

final tlWorkspacesStateProvider =
    StateNotifierProvider<TLWorkspacesNotifier, TLWorkspacesState>((ref) {
  return TLWorkspacesNotifier();
});

class TLWorkspacesNotifier extends StateNotifier<TLWorkspacesState> {
  TLWorkspacesNotifier()
      : super(TLWorkspacesState(workspaces: [], currentWorkspaceIndex: 0)) {
    _loadWorkspaces();
  }

  Future<void> _loadWorkspaces() async {
    final pref = await TLPref().getPref;
    final currentWorkspaceIndex = pref.getInt('currentWorkspaceIndex') ?? 0;
    // ここでワークスペースをロードする
    final encodedTLWorkspaces = pref.getString("tlWorkspaces");
    if (encodedTLWorkspaces != null) {
      final List<dynamic> jsonTLWorkspaces = jsonDecode(encodedTLWorkspaces);
      final List<TLWorkspace> readWorkspaces = jsonTLWorkspaces.map((jsonData) {
        return TLWorkspace.fromJson(jsonData);
      }).toList();
      state = state.copyWith(workspaces: readWorkspaces);
    }
    state = state.copyWith(currentWorkspaceIndex: currentWorkspaceIndex);
  }

  Future<void> changeCurrentWorkspaceIndex(int newIndex) async {
    state = state.copyWith(currentWorkspaceIndex: newIndex);
    final pref = await TLPref().getPref;
    pref.setInt('currentWorkspaceIndex', newIndex);
  }

  void updateCurrentWorkspace(TLWorkspace updatedWorkspace) {
    final updatedWorkspaces = List<TLWorkspace>.from(state.workspaces);
    updatedWorkspaces[state.currentWorkspaceIndex] = updatedWorkspace;
    state = state.copyWith(workspaces: updatedWorkspaces);
  }
}
