import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

class TLWorkspaceID {
  static const String school = "schoolWorksapceId";
  static const String supermarket = "superMarcketId";
  static const String vegetable = "vegetableId";
}

class TLCategoryID {
  static const String none = noneID;
  static const String supermarket = "superMarcketId";
  static const String hundredStore = "hundredStoreId";
  static const String vegetable = "vegetableId";
  static const String math = "mathId";
  static const String mathA = "mathAId";
  static const String mathI = "mathIId";
  static const String english = "englishId";
}

final List<TLWorkspace> initialTLWorkspaces = [
  TLWorkspace(
      id: TLWorkspaceID.supermarket,
      name: "Shopping",
      bigCategories: const [
        TLToDoCategory(
            id: TLCategoryID.none, parentBigCategoryID: null, name: "なし"),
        TLToDoCategory(
            id: TLCategoryID.supermarket,
            parentBigCategoryID: null,
            name: "スーパー"),
        TLToDoCategory(
            id: TLCategoryID.hundredStore,
            parentBigCategoryID: null,
            name: "100均"),
      ],
      smallCategories: {
        TLCategoryID.none: [],
        TLCategoryID.supermarket: [
          const TLToDoCategory(
              id: TLCategoryID.vegetable,
              parentBigCategoryID: TLCategoryID.supermarket,
              name: "野菜"),
        ],
        TLCategoryID.hundredStore: [],
      },
      categoryIDToToDos: {
        TLCategoryID.none: const TLToDosInTodayAndWhenever(toDosInToday: [
          TLToDo(
              id: "todo1",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.none,
              content: "のり",
              steps: []),
          TLToDo(
              id: "todo2",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.none,
              content: "まくらカバー",
              steps: []),
        ], toDosInWhenever: []),
        TLCategoryID.supermarket:
            const TLToDosInTodayAndWhenever(toDosInToday: [
          TLToDo(
              id: "todo3",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.supermarket,
              content: "パスタ",
              steps: [
                TLStep(id: "step1", content: "パスタの束"),
                TLStep(id: "step2", content: "オリーブオイル")
              ]),
        ], toDosInWhenever: []),
        TLCategoryID.vegetable: const TLToDosInTodayAndWhenever(toDosInToday: [
          TLToDo(
              id: "todo4",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.vegetable,
              content: "キャベツ",
              steps: []),
          TLToDo(
              id: "todo5",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.vegetable,
              content: "にんじん",
              steps: []),
        ], toDosInWhenever: []),
        TLCategoryID.hundredStore:
            const TLToDosInTodayAndWhenever(toDosInToday: [
          TLToDo(
              id: "todo6",
              workspaceID: TLCategoryID.none,
              categoryID: TLCategoryID.hundredStore,
              content: "お皿",
              steps: [])
        ], toDosInWhenever: []),
      }),
  // --- 学校
  TLWorkspace(id: TLWorkspaceID.school, name: "School", bigCategories: const [
    TLToDoCategory(
        id: TLCategoryID.none, parentBigCategoryID: null, name: "なし"),
    TLToDoCategory(
        id: TLCategoryID.math, parentBigCategoryID: null, name: "数学"),
    TLToDoCategory(
        id: TLCategoryID.english, parentBigCategoryID: null, name: "英語"),
  ], smallCategories: {
    TLCategoryID.none: [],
    TLCategoryID.math: const [
      TLToDoCategory(
          id: TLCategoryID.mathA,
          parentBigCategoryID: TLCategoryID.math,
          name: "数学A"),
      TLToDoCategory(
          id: TLCategoryID.mathI,
          parentBigCategoryID: TLCategoryID.math,
          name: "数学I")
    ],
    TLCategoryID.english: []
  }, categoryIDToToDos: {
    TLCategoryID.none: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo7",
          workspaceID: TLWorkspaceID.school,
          categoryID: TLCategoryID.none,
          content: "~のプリントを出す",
          steps: [])
    ], toDosInWhenever: []),
    TLCategoryID.math:
        const TLToDosInTodayAndWhenever(toDosInToday: [], toDosInWhenever: []),
    TLCategoryID.mathA: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo8",
          workspaceID: TLWorkspaceID.school,
          categoryID: TLCategoryID.mathA,
          content: "~を復習する",
          steps: []),
      TLToDo(
          id: "todo9",
          workspaceID: TLWorkspaceID.school,
          categoryID: TLCategoryID.mathA,
          content: "ワーク12ページの宿題をやる",
          steps: []),
    ], toDosInWhenever: []),
    TLCategoryID.mathI: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo10",
          workspaceID: TLWorkspaceID.school,
          categoryID: TLCategoryID.mathI,
          content: "ドリル20~25ページ",
          steps: [])
    ], toDosInWhenever: []),
    TLCategoryID.english: const TLToDosInTodayAndWhenever(toDosInToday: [
      TLToDo(
          id: "todo11",
          workspaceID: TLWorkspaceID.school,
          categoryID: TLCategoryID.mathI,
          content: "単語帳301~400",
          steps: [])
    ], toDosInWhenever: []),
  }),
];
