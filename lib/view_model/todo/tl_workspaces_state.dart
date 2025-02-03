import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const String noneID = "defaultID";

class TLWorkspacesState {
  final List<TLWorkspace> tlWorkspaces;
  final int currentWorkspaceIndex;

  TLWorkspacesState({
    required this.tlWorkspaces,
    required this.currentWorkspaceIndex,
  });

  TLWorkspace get currentWorkspace => tlWorkspaces[currentWorkspaceIndex];

  TLWorkspacesState copyWith({
    List<TLWorkspace>? tlWorkspaces,
    int? currentWorkspaceIndex,
  }) {
    return TLWorkspacesState(
      tlWorkspaces: tlWorkspaces ?? this.tlWorkspaces,
      currentWorkspaceIndex:
          currentWorkspaceIndex ?? this.currentWorkspaceIndex,
    );
  }
}

final tlWorkspacesStateProvider =
    StateNotifierProvider<TLWorkspacesStateNotifier, TLWorkspacesState>((ref) {
  return TLWorkspacesStateNotifier();
});

class TLWorkspacesStateNotifier extends StateNotifier<TLWorkspacesState> {
  TLWorkspacesStateNotifier()
      : super(TLWorkspacesState(
            tlWorkspaces: _initialTLWorkspaces, currentWorkspaceIndex: 0)) {
    _loadWorkspaces();
  }

  // -- load

  Future<void> _loadWorkspaces() async {
    final pref = await TLPrefService().getPref;
    final currentWorkspaceIndex = pref.getInt('currentWorkspaceIndex') ?? 0;
    // ここでワークスペースをロードする
    final encodedTLWorkspaces = pref.getString("tlWorkspaces");
    if (encodedTLWorkspaces != null) {
      final List<dynamic> jsonTLWorkspaces = jsonDecode(encodedTLWorkspaces);
      final List<TLWorkspace> readWorkspaces = jsonTLWorkspaces.map((jsonData) {
        return TLWorkspace.fromJson(jsonData);
      }).toList();
      state = state.copyWith(tlWorkspaces: readWorkspaces);
    }
    state = state.copyWith(currentWorkspaceIndex: currentWorkspaceIndex);
  }

  // -- body

  Future<void> changeCurrentWorkspaceIndex(int newIndex) async {
    state = state.copyWith(currentWorkspaceIndex: newIndex);
    final pref = await TLPrefService().getPref;
    pref.setInt('currentWorkspaceIndex', newIndex);
  }

  Future<void> addWorkspace(TLWorkspace newWorkspace) async {
    final updatedWorkspaces = List<TLWorkspace>.from(state.tlWorkspaces)
      ..add(newWorkspace);
    state = state.copyWith(tlWorkspaces: updatedWorkspaces);
    await _saveWorkspaces();
  }

  // TLWorkspaceを削除するメソッド
  Future<void> removeWorkspace({required String corrWorkspaceId}) async {
    final updatedWorkspaceList = state.tlWorkspaces
        .where((workspace) => workspace.id != corrWorkspaceId)
        .toList();
    state = state.copyWith(tlWorkspaces: updatedWorkspaceList);
    await _saveWorkspaces();
  }

  // -- save
  Future<void> _saveWorkspaces() async {
    final pref = await TLPrefService().getPref;
    final encodedTLWorkspaces = jsonEncode(
        state.tlWorkspaces.map((workspace) => workspace.toJson()).toList());
    TLMethodChannelService.updateTLWorkspaces(
        encodedTLWorkspaces: encodedTLWorkspaces);
    await pref.setString("tlWorkspaces", encodedTLWorkspaces);
  }

  void updateCurrentWorkspace(
      {required TLWorkspace updatedCurrentWorkspace}) async {
    final updatedWorkspaces = List<TLWorkspace>.from(state.tlWorkspaces);
    updatedWorkspaces[state.currentWorkspaceIndex] = updatedCurrentWorkspace;
    state = state.copyWith(tlWorkspaces: updatedWorkspaces);
    await _saveWorkspaces();
  }

  // List<TLWorkspace>を更新するメソッド
  Future<void> updateTLWorkspaceList(
      {required List<TLWorkspace> updatedTLWorkspaceList}) async {
    state = state.copyWith(tlWorkspaces: updatedTLWorkspaceList);
    await _saveWorkspaces();
  }
}
