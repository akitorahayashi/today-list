import 'package:today_list/model/workspace/provider/current_tl_workspace_provider.dart';

import '../../external/tl_pref.dart';
import '../../todo/tl_category.dart';
import '../../todo/tl_todo.dart';
import '../../todo/tl_todos.dart';
import '../../todo/tl_step.dart';
import '../tl_workspace.dart';

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String noneID = "defaultID";

// TLWorkspacesを提供するProvider
final tlWorkspacesProvider =
    StateNotifierProvider<TLWorkspacesNotifier, List<TLWorkspace>>((ref) {
  return TLWorkspacesNotifier(ref);
});

class TLWorkspacesNotifier extends StateNotifier<List<TLWorkspace>> {
  final Ref ref;
  TLWorkspacesNotifier(this.ref) : super(_initialTLWorkspaces) {
    // コンストラクタ、SharedPreferenceからデータを取得
    _loadTLWorkspaces();
  }

  Future<void> _loadTLWorkspaces() async {
    final pref = await TLPref().getPref;
    final encodedTLWorkspaces = pref.getString("tlWorkspaces");
    if (encodedTLWorkspaces != null) {
      final List<dynamic> jsonTLWorkspaces = jsonDecode(encodedTLWorkspaces);
      final List<TLWorkspace> savedTLWorkspaces =
          jsonTLWorkspaces.map((jsonData) {
        return TLWorkspace.fromJson(jsonData);
      }).toList();
      state = savedTLWorkspaces;
    }
  }

  Future<void> _saveWorkspaces() async {
    final pref = await TLPref().getPref;
    final encodedTLWorkspaces =
        jsonEncode(state.map((workspace) => workspace.toJson()).toList());
    await pref.setString("tlWorkspaces", encodedTLWorkspaces);
  }

  // TLWorkspaceを追加するメソッド
  Future<void> addWorkspace({required TLWorkspace newTLWorkspace}) async {
    state = [...state, newTLWorkspace];
    await _saveWorkspaces();
  }

  // TLWorkspaceを削除するメソッド
  Future<void> removeWorkspace({required String corrWorkspaceId}) async {
    state =
        state.where((workspace) => workspace.id != corrWorkspaceId).toList();
    await _saveWorkspaces();
  }

  // CurrentTLWorkspaceを更新するメソッド
  Future<void> updateCurrentWorkspace({
    required TLWorkspace updatedWorkspace,
  }) async {
    final newList = [...state];
    newList[ref.read(currentWorkspaceProvider.notifier).currentWorkspaceIndex] =
        updatedWorkspace;
    state = newList;
    await _saveWorkspaces();
  }

  // List<TLWorkspace>を更新するメソッド
  Future<void> updateTLWorkspaceList(
      {required List<TLWorkspace> updatedTLWorkspaceList}) async {
    state = updatedTLWorkspaceList;
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
