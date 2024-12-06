import 'package:today_list/model/external/tl_method_channel.dart';
import 'package:today_list/model/external/tl_pref.dart';
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
    final pref = await TLPref().getPref;
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
    final pref = await TLPref().getPref;
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
    final pref = await TLPref().getPref;
    final encodedTLWorkspaces = jsonEncode(
        state.tlWorkspaces.map((workspace) => workspace.toJson()).toList());
    TLMethodChannel.updateTLWorkspaces(
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

final List<TLWorkspace> _initialTLWorkspaces = [
  TLWorkspace(id: "defaultWorkspaceId", name: "Default", bigCategories: [
    TLCategory(id: noneID, title: "なし"),
    TLCategory(id: "superMarcketId", title: "スーパー"),
    TLCategory(id: "hundredStoreId", title: "100均"),
  ], smallCategories: {
    noneID: [],
    "superMarcketId": [
      TLCategory(id: "vegetableId", title: "野菜"),
    ],
    "hundredStoreId": [],
  }, categoryIDToToDos: {
    noneID: TLToDos(toDosInToday: [
      TLToDo(id: "todo1", title: "のり", steps: []),
      TLToDo(id: "todo2", title: "まくらカバー", steps: []),
    ], toDosInWhenever: []),
    "superMarcketId": TLToDos(toDosInToday: [
      TLToDo(id: "todo3", title: "パスタ", steps: [
        TLStep(id: "step1", title: "パスタの束"),
        TLStep(id: "step2", title: "オリーブオイル")
      ]),
    ], toDosInWhenever: []),
    "vegetableId": TLToDos(toDosInToday: [
      TLToDo(id: "todo4", title: "キャベツ", steps: []),
      TLToDo(id: "todo5", title: "にんじん", steps: []),
    ], toDosInWhenever: []),
    "hundredStoreId": TLToDos(
        toDosInToday: [TLToDo(id: "todo6", title: "お皿", steps: [])],
        toDosInWhenever: []),
  }),
  // --- 学校
  TLWorkspace(id: "schoolWorksapceId", name: "School", bigCategories: [
    TLCategory(id: noneID, title: "なし"),
    TLCategory(id: "mathId", title: "数学"),
    TLCategory(id: "englishId", title: "英語"),
  ], smallCategories: {
    noneID: [],
    "mathId": [
      TLCategory(id: "mathAId", title: "数学A"),
      TLCategory(id: "mathIId", title: "数学I")
    ],
    "englishId": []
  }, categoryIDToToDos: {
    noneID: TLToDos(
        toDosInToday: [TLToDo(id: "todo7", title: "~のプリントを出す", steps: [])],
        toDosInWhenever: []),
    "mathId": TLToDos(toDosInToday: [], toDosInWhenever: []),
    "mathAId": TLToDos(toDosInToday: [
      TLToDo(id: "todo8", title: "~を復習する", steps: []),
      TLToDo(id: "todo9", title: "ワーク12ページの宿題をやる", steps: []),
    ], toDosInWhenever: []),
    "mathIId": TLToDos(
        toDosInToday: [TLToDo(id: "todo10", title: "ドリル20~25ページ", steps: [])],
        toDosInWhenever: []),
    "englishId": TLToDos(
        toDosInToday: [TLToDo(id: "todo11", title: "単語帳301~400", steps: [])],
        toDosInWhenever: []),
  }),
];
