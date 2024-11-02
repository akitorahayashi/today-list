import '../external/tl_pref.dart';
import '../todo/tl_category.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_step.dart';
import 'tl_workspace.dart';

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Operations for categories are located in `tl_category.dart`.
// Operations for todo are located in `tl_todo.dart` and `tl_todos.dart`.
// Operations for step are located in `tl_step.dart`.

// TODO defaultIDというグローバル変数を削除しても機能するようにする
const String defaultID = "defaultID";

// TLWorkspacesを提供するProvider
final tlWorkspacesProvider =
    StateNotifierProvider.autoDispose<TLWorkspacesNotifier, List<TLWorkspace>>(
        (ref) {
  return TLWorkspacesNotifier();
});

class TLWorkspacesNotifier extends StateNotifier<List<TLWorkspace>> {
  TLWorkspacesNotifier() : super(_initialTLWorkspaces) {
    // コンストラクタ、SharedPreferenceからデータを取得
    _loadInitialWorkspaces();
  }

  Future<void> _loadInitialWorkspaces() async {
    final pref = await TLPref().getPref;
    final encodedTLWorkspaces = pref.getString("tlWorkspaces");
    if (encodedTLWorkspaces != null) {
      final List<dynamic> _jsonTLWorkspaces = json.decode(encodedTLWorkspaces);
      final List<TLWorkspace> _savedTLWorkspaces =
          _jsonTLWorkspaces.map((jsonData) {
        return TLWorkspace.fromJson(jsonData);
      }).toList();
      state = _savedTLWorkspaces;
    }
  }

  Future<void> _saveWorkspaces() async {
    final pref = await TLPref().getPref;
    final encodedTLWorkspaces =
        json.encode(state.map((workspace) => workspace.toJson()).toList());
    await pref.setString("tlWorkspaces", encodedTLWorkspaces);
  }

  // TLWorkspaceを追加するメソッド
  Future<void> addTLWorkspace({required TLWorkspace newTLWorkspace}) async {
    state = [...state, newTLWorkspace];
    await _saveWorkspaces();
  }

  // TLWorkspaceを削除するメソッド
  Future<void> removeTLWorkspace({required String workspaceId}) async {
    state = state.where((workspace) => workspace.id != workspaceId).toList();
    await _saveWorkspaces();
  }

  // TLWorkspaceを更新するメソッド
  Future<void> updateTLWorkspace(
      {required int indexInWorkspaceList,
      required TLWorkspace updatedTLWorkspace}) async {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == indexInWorkspaceList) updatedTLWorkspace else state[i],
    ];
    await _saveWorkspaces();
  }
}

final List<TLWorkspace> _initialTLWorkspaces = [
  TLWorkspace(id: "defaultWorkspaceId", name: "Default", bigCategories: [
    TLCategory(id: defaultID, title: "なし"),
    TLCategory(id: "superMarcketId", title: "スーパー"),
    TLCategory(id: "hundredStoreId", title: "100均"),
  ], smallCategories: {
    defaultID: [],
    "superMarcketId": [
      TLCategory(id: "vegetableId", title: "野菜"),
    ],
    "hundredStoreId": [],
  }, toDos: {
    defaultID: TLToDos(toDosInToday: [
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
    TLCategory(id: defaultID, title: "なし"),
    TLCategory(id: "mathId", title: "数学"),
    TLCategory(id: "englishId", title: "英語"),
  ], smallCategories: {
    defaultID: [],
    "mathId": [
      TLCategory(id: "mathAId", title: "数学A"),
      TLCategory(id: "mathIId", title: "数学I")
    ],
    "englishId": []
  }, toDos: {
    defaultID: TLToDos(
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
