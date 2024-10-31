import '../external/tl_pref.dart';
import '../todo/tl_category.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_step.dart';
import '../user/setting_data.dart';
import 'tl_workspace.dart';

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    TLPref().getPref.then((pref) {
      final encodedTLWorkspaces = pref.getString("tlWorkspaces");
      if (encodedTLWorkspaces != null) {
        final List<dynamic> _jsonTLWorkspaces =
            json.decode(encodedTLWorkspaces);
        final List<TLWorkspace> _savedTLWorkspaces =
            _jsonTLWorkspaces.map((jsonData) {
          return TLWorkspace.fromJson(jsonData);
        }).toList();
        state = _savedTLWorkspaces;
      }
    });
  }

  // TLWorkspaceを追加するメソッド
  void addTLWorkspace({required TLWorkspace newTLWorkspace}) {
    this.state = [...state, newTLWorkspace];
  }

  // TLWorkspaceを削除するメソッド
  void removeTLWorkspace({required String coorId}) {
    this.state = this
        .state
        .where((oneOfTLWorkspaces) => oneOfTLWorkspaces.id != coorId)
        .toList(); // ID でフィルタリングして削除
  }

  // TLWorkspaceを更新するメソッド
  void updateTLWorkspace(
      {required int indexInUsers, required TLWorkspace updatedTLWorkspace}) {
    // リスト全体を新しいリストとして再設定することで再描画をトリガーする
    state = [
      for (int i = 0; i < this.state.length; i++)
        if (i == indexInUsers) updatedTLWorkspace else this.state[i],
    ];
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
