import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

final List<TLWorkspace> initialTLWorkspaces = [
  TLWorkspace(id: noneID, name: "Shopping", bigCategories: const [
    TLToDoCategory(id: noneID, parentBigCategoryID: null, name: "なし"),
    TLToDoCategory(
        id: "superMarcketId", parentBigCategoryID: null, name: "スーパー"),
    TLToDoCategory(
        id: "hundredStoreId", parentBigCategoryID: null, name: "100均"),
  ], smallCategories: {
    noneID: [],
    "superMarcketId": [
      const TLToDoCategory(
          id: "vegetableId", parentBigCategoryID: "superMarcketId", name: "野菜"),
    ],
    "hundredStoreId": [],
  }, categoryIDToToDos: {
    noneID: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(id: "todo1", categoryID: noneID, content: "のり", steps: []),
      TLToDo(id: "todo2", categoryID: noneID, content: "まくらカバー", steps: []),
    ], toDosInWhenever: []),
    "superMarcketId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(id: "todo3", categoryID: "superMarcketId", content: "パスタ", steps: [
        TLStep(id: "step1", content: "パスタの束"),
        TLStep(id: "step2", content: "オリーブオイル")
      ]),
    ], toDosInWhenever: []),
    "vegetableId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo4", categoryID: "vegetableId", content: "キャベツ", steps: []),
      TLToDo(
          id: "todo5", categoryID: "vegetableId", content: "にんじん", steps: []),
    ], toDosInWhenever: []),
    "hundredStoreId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo6", categoryID: "hundredStoreId", content: "お皿", steps: [])
    ], toDosInWhenever: []),
  }),
  // --- 学校
  TLWorkspace(id: "schoolWorksapceId", name: "School", bigCategories: const [
    TLToDoCategory(id: noneID, parentBigCategoryID: null, name: "なし"),
    TLToDoCategory(id: "mathId", parentBigCategoryID: null, name: "数学"),
    TLToDoCategory(id: "englishId", parentBigCategoryID: null, name: "英語"),
  ], smallCategories: {
    noneID: [],
    "mathId": const [
      TLToDoCategory(id: "mathAId", parentBigCategoryID: "mathId", name: "数学A"),
      TLToDoCategory(id: "mathIId", parentBigCategoryID: "mathId", name: "数学I")
    ],
    "englishId": []
  }, categoryIDToToDos: {
    noneID: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(id: "todo7", categoryID: noneID, content: "~のプリントを出す", steps: [])
    ], toDosInWhenever: []),
    "mathId":
        const TLToDosInTodayAndWhenever(toDosInToday: [], toDosInWhenever: []),
    "mathAId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(id: "todo8", categoryID: "mathAId", content: "~を復習する", steps: []),
      TLToDo(
          id: "todo9",
          categoryID: "mathAId",
          content: "ワーク12ページの宿題をやる",
          steps: []),
    ], toDosInWhenever: []),
    "mathIId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo10",
          categoryID: "mathIId",
          content: "ドリル20~25ページ",
          steps: [])
    ], toDosInWhenever: []),
    "englishId": const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo11", categoryID: "mathIId", content: "単語帳301~400", steps: [])
    ], toDosInWhenever: []),
  }),
];
