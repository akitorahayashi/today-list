import '../tl_category.dart';
import '../todo/tl_todo.dart';
import '../todo/tl_todos.dart';
import '../todo/tl_step.dart';
import 'workspace.dart';

const String noneId = "---n";

const String swToDoId = "swToDoId";
const String swCategoryId = "swCategoryId";
const String swWorkspaceId = "swWorkspaceId";

const String superMarcketId = "superMarcketId";
const String vegetableId = "vegetableId";
const String hundredStoreId = "hundredStoreId";

const String mathId = "mathId";
const String mathAId = "mathAId";
const String mathIId = "mathIId";
const String englishId = "englishId";

// List<TLCategory> workspaceCategories = [
//   TLCategory(id: noneId, title: "なし"),
// ];

Map<String, List<Map<String, dynamic>>> workspaces = {
  noneId: [
    // --- 使い方
    Workspace(name: "デフォルト", bigCategories: [
      TLCategory(id: noneId, title: "なし"),
      TLCategory(id: swToDoId, title: "ToDo"),
      TLCategory(id: swCategoryId, title: "Category"),
      TLCategory(id: swWorkspaceId, title: "Workspace"),
    ], smallCategories: {
      noneId: [],
      swToDoId: [],
      swCategoryId: [],
      swWorkspaceId: [],
    }, toDos: {
      noneId: TLToDos(toDosInToday: [
        TLToDo(title: "Today Listはデザイン性に優れたToDoアプリ!", steps: [
          TLStep(title: "カテゴリー分けを駆使して整理!"),
          TLStep(title: "テーマカラーやチェックボックスを変えて自分好みのToDoアプリを作ろう!"),
        ]),
      ], toDosInWhenever: []),
      // --- ToDo
      swToDoId: TLToDos(toDosInToday: [
        TLToDo(title: "ホーム画面下の+マークから追加できます", steps: []),
        TLToDo(
            title: "このToDoカードを左右にスライドすることで編集したり、削除することができます",
            steps: [TLStep(title: "「今日」から「いつでも」にすぐ変更もできます!")]),
        TLToDo(title: "左下のチェックボタンからチェックしたToDoを一括削除!", steps: []),
      ], toDosInWhenever: []),
      // --- Category
      swCategoryId: TLToDos(toDosInToday: [
        TLToDo(title: "右下のリストのボタンからカテゴリーリストを開くことができます", steps: [
          TLStep(title: "+マークでカテゴリーを追加"),
          TLStep(title: "カテゴリーのカードをタップすることで「今日」と「いつでも」のToDoを一つの画面で管理できます"),
          TLStep(title: "「いつでも」に入れたToDoはカードをスライドしてこの画面から「今日」にしよう!!"),
        ]),
        TLToDo(
            title: "「今日」「いつでも」のToDoを一度に管理できる画面を開いて右上の鉛筆ボタンからカテゴリーを編集、削除できます!",
            steps: []),
      ], toDosInWhenever: []),
      // ---Workspace
      swWorkspaceId: TLToDos(toDosInToday: [
        TLToDo(title: "WorkspaceはCategoryとそれに伴うToDoを一括で管理する場所です!", steps: [
          TLStep(title: "Worksapceを変えることで、違ったカテゴリーを区別してまとめることができる!")
        ]),
        TLToDo(
            title: "ホーム画面左上のメニューボタンからWorkspaceの一覧を見ることができます",
            steps: [TLStep(title: "一覧の中の+ボタンからworkspaceを追加!")]),
        TLToDo(
            title: "Worspaceを編集したいときは一覧からManage Workspace(管理画面)を開こう!",
            steps: [TLStep(title: "-ボタンで削除、鉛筆ボタンで名前を編集できます!")]),
      ], toDosInWhenever: []),
    }).toJson(),
    // --- 買い物
    Workspace(name: "買い物", bigCategories: [
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
        TLToDo(title: "のり", steps: []),
        TLToDo(title: "まくらカバー", steps: [])
      ], toDosInWhenever: []),
      superMarcketId: TLToDos(toDosInToday: [
        TLToDo(
            title: "パスタ",
            steps: [TLStep(title: "パスタの束"), TLStep(title: "オリーブオイル")]),
      ], toDosInWhenever: []),
      vegetableId: TLToDos(toDosInToday: [
        TLToDo(title: "キャベツ", steps: []),
        TLToDo(title: "にんじん", steps: []),
      ], toDosInWhenever: []),
      hundredStoreId: TLToDos(
          toDosInToday: [TLToDo(title: "お皿", steps: [])], toDosInWhenever: []),
    }).toJson(),
    // --- 学校
    Workspace(name: "学校", bigCategories: [
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
          toDosInToday: [TLToDo(title: "~のプリントを出す", steps: [])],
          toDosInWhenever: []),
      mathId: TLToDos(toDosInToday: [], toDosInWhenever: []),
      mathAId: TLToDos(toDosInToday: [
        TLToDo(title: "~を復習する", steps: []),
        TLToDo(title: "ワーク12ページの宿題をやる", steps: []),
      ], toDosInWhenever: []),
      mathIId: TLToDos(
          toDosInToday: [TLToDo(title: "ドリル20~25ページ", steps: [])],
          toDosInWhenever: []),
      englishId: TLToDos(
          toDosInToday: [TLToDo(title: "単語帳301~400", steps: [])],
          toDosInWhenever: []),
    }).toJson(),
  ]
};
