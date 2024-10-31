import '../todo/tl_category.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_step.dart';
import 'tl_workspace.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

const String defaultID = "defaultID";

final rpUsersProvider =
    StateNotifierProvider.autoDispose<RPUserNotifier, List<RPUser>>((ref) {
  return RPUserNotifier();
});

// 自分でカスタマイズしたdisposeを実装する場合
// final counterProvider = StateNotifierProvider<RPUserNotifier, int>((ref) {
//   final notifier = RPUserNotifier();

//   ref.onDispose(() {
//     notifier.dispose();
//   });

//   return notifier;
// });

// class RPUserNotifier extends StateNotifier<List<RPUser>> {
//   RPUserNotifier() : super([]);

//   // ユーザーを追加するメソッド
//   void addUser(RPUser user) {
//     state = [...state, user]; // 新しいユーザーをリストに追加
//   }

//   // ユーザーを削除するメソッド
//   void removeUser(String id) {
//     state = state.where((user) => user.id != id).toList(); // ID でフィルタリングして削除
//   }

//   // ユーザーを更新するメソッド
//   void updateUser({required int indexInUsers, required RPUser updatedUser}) {
//     // リスト全体を新しいリストとして再設定することで再描画をトリガーする
//     state = [
//       for (int i = 0; i < state.length; i++)
//         if (i == indexInUsers) updatedUser else state[i],
//     ];
//   }
// }

List<Map<String, dynamic>> tlworkspaces = [
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
  }).toJson(),
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
  }).toJson(),
];
