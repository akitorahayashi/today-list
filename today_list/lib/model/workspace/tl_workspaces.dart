import '../tl_category.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_step.dart';
import 'tl_workspace.dart';

const String noneId = "---n";

const String superMarcketId = "superMarcketId";
const String vegetableId = "vegetableId";
const String hundredStoreId = "hundredStoreId";

const String mathId = "mathId";
const String mathAId = "mathAId";
const String mathIId = "mathIId";
const String englishId = "englishId";

List<Map<String, dynamic>> tlworkspaces = [
  TLWorkspace(id: "defaultWorkspaceId", name: "Default", bigCategories: [
    TLCategory(id: noneId, title: "なし"),
    TLCategory(id: superMarcketId, title: "スーパー"),
    TLCategory(id: hundredStoreId, title: "100均"),
  ], smallCategories: {
    noneId: [],
    superMarcketId: [
      TLCategory(id: vegetableId, title: "野菜"),
    ],
    hundredStoreId: [],
  }, toDos: {
    noneId: TLToDos(toDosInToday: [
      TLToDo(id: "todo1", title: "のり", steps: []),
      TLToDo(id: "todo2", title: "まくらカバー", steps: []),
    ], toDosInWhenever: []),
    superMarcketId: TLToDos(toDosInToday: [
      TLToDo(id: "todo3", title: "パスタ", steps: [
        TLStep(id: "step1", title: "パスタの束"),
        TLStep(id: "step2", title: "オリーブオイル")
      ]),
    ], toDosInWhenever: []),
    vegetableId: TLToDos(toDosInToday: [
      TLToDo(id: "todo4", title: "キャベツ", steps: []),
      TLToDo(id: "todo5", title: "にんじん", steps: []),
    ], toDosInWhenever: []),
    hundredStoreId: TLToDos(
        toDosInToday: [TLToDo(id: "todo6", title: "お皿", steps: [])],
        toDosInWhenever: []),
  }).toJson(),
  // --- 学校
  TLWorkspace(id: "schoolWorksapceId", name: "School", bigCategories: [
    TLCategory(id: noneId, title: "なし"),
    TLCategory(id: mathId, title: "数学"),
    TLCategory(id: englishId, title: "英語"),
  ], smallCategories: {
    noneId: [],
    mathId: [
      TLCategory(id: mathAId, title: "数学A"),
      TLCategory(id: mathIId, title: "数学I")
    ],
    englishId: []
  }, toDos: {
    noneId: TLToDos(
        toDosInToday: [TLToDo(id: "todo7", title: "~のプリントを出す", steps: [])],
        toDosInWhenever: []),
    mathId: TLToDos(toDosInToday: [], toDosInWhenever: []),
    mathAId: TLToDos(toDosInToday: [
      TLToDo(id: "todo8", title: "~を復習する", steps: []),
      TLToDo(id: "todo9", title: "ワーク12ページの宿題をやる", steps: []),
    ], toDosInWhenever: []),
    mathIId: TLToDos(
        toDosInToday: [TLToDo(id: "todo10", title: "ドリル20~25ページ", steps: [])],
        toDosInWhenever: []),
    englishId: TLToDos(
        toDosInToday: [TLToDo(id: "todo11", title: "単語帳301~400", steps: [])],
        toDosInWhenever: []),
  }).toJson(),
];
