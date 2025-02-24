// ignore_for_file: library_private_types_in_public_api
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

final List<TLWorkspace> initialTLWorkspaces = [
  // MARK: - Work Workspace
  TLWorkspace(
    id: _WorkspaceID.work.rawValue,
    name: "Work",
    bigCategories: [
      TLToDoCategory(
        id: _BigCategoryID.projectA.rawValue,
        parentBigCategoryID: null,
        name: _BigCategoryID.projectA.name,
      ),
    ],
    smallCategories: {
      _BigCategoryID.projectA.rawValue: [],
    },
    categoryIDToToDos: {
      _WorkspaceID.work.rawValue:
          TLToDosInTodayAndWhenever(categoryID: _WorkspaceID.work.rawValue),
      _BigCategoryID.projectA.rawValue: TLToDosInTodayAndWhenever(
        categoryID: _BigCategoryID.projectA.rawValue,
        toDosInToday: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.work.rawValue,
            categoryID: _BigCategoryID.projectA.rawValue,
            isInToday: true,
            content: "Aさんとのスケジュールを調整",
          ),
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.work.rawValue,
            categoryID: _BigCategoryID.projectA.rawValue,
            isInToday: true,
            content: "書類の作成",
            steps: [
              TLStep(id: TLUUIDGenerator.generate(), content: "資料を用意する"),
              TLStep(id: TLUUIDGenerator.generate(), content: "送り先に送信する"),
            ],
          ),
        ],
        toDosInWhenever: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.work.rawValue,
            categoryID: _BigCategoryID.projectA.rawValue,
            isInToday: false,
            content: "次回会議の資料作成",
            steps: [
              TLStep(id: TLUUIDGenerator.generate(), content: "構成を考える"),
              TLStep(id: TLUUIDGenerator.generate(), content: "スライド作成"),
              TLStep(id: TLUUIDGenerator.generate(), content: "チームに共有"),
            ],
          ),
        ],
      ),
    },
  ),

  // MARK: - Life Workspace
  TLWorkspace(
    id: _WorkspaceID.life.rawValue,
    name: "Life",
    bigCategories: [
      TLToDoCategory(
        id: _BigCategoryID.mealPrep.rawValue,
        parentBigCategoryID: null,
        name: _BigCategoryID.mealPrep.name,
      ),
    ],
    smallCategories: {
      _BigCategoryID.mealPrep.rawValue: [
        TLToDoCategory(
          id: _SmallCategoryID.breakfast.rawValue,
          parentBigCategoryID: _BigCategoryID.mealPrep.rawValue,
          name: _SmallCategoryID.breakfast.name,
        ),
        TLToDoCategory(
          id: _SmallCategoryID.lunch.rawValue,
          parentBigCategoryID: _BigCategoryID.mealPrep.rawValue,
          name: _SmallCategoryID.lunch.name,
        ),
        TLToDoCategory(
          id: _SmallCategoryID.dinner.rawValue,
          parentBigCategoryID: _BigCategoryID.mealPrep.rawValue,
          name: _SmallCategoryID.dinner.name,
        ),
      ],
    },
    categoryIDToToDos: {
      _WorkspaceID.life.rawValue:
          TLToDosInTodayAndWhenever(categoryID: _WorkspaceID.life.rawValue),
      _BigCategoryID.mealPrep.rawValue: TLToDosInTodayAndWhenever(
          categoryID: _BigCategoryID.mealPrep.rawValue),
      _SmallCategoryID.breakfast.rawValue: TLToDosInTodayAndWhenever(
        categoryID: _SmallCategoryID.breakfast.rawValue,
        toDosInToday: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.life.rawValue,
            categoryID: _SmallCategoryID.breakfast.rawValue,
            isInToday: true,
            content: "ご飯を炊く",
          ),
        ],
        toDosInWhenever: [],
      ),
      _SmallCategoryID.lunch.rawValue: TLToDosInTodayAndWhenever(
          categoryID: _SmallCategoryID.lunch.rawValue,
          toDosInToday: [],
          toDosInWhenever: []),
      _SmallCategoryID.dinner.rawValue: TLToDosInTodayAndWhenever(
        categoryID: _SmallCategoryID.dinner.rawValue,
        toDosInToday: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.life.rawValue,
            categoryID: _SmallCategoryID.dinner.rawValue,
            isInToday: true,
            content: "鶏むね肉の照り焼き",
            steps: [
              TLStep(id: TLUUIDGenerator.generate(), content: "鶏むね肉"),
              TLStep(id: TLUUIDGenerator.generate(), content: "醤油"),
              TLStep(id: TLUUIDGenerator.generate(), content: "みりん"),
              TLStep(id: TLUUIDGenerator.generate(), content: "砂糖"),
            ],
          ),
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _WorkspaceID.life.rawValue,
            categoryID: _SmallCategoryID.dinner.rawValue,
            isInToday: true,
            content: "じゃがいもと玉ねぎの味噌汁",
            steps: [
              TLStep(id: TLUUIDGenerator.generate(), content: "じゃがいも"),
              TLStep(id: TLUUIDGenerator.generate(), content: "玉ねぎ"),
              TLStep(id: TLUUIDGenerator.generate(), content: "味噌"),
            ],
          ),
        ],
        toDosInWhenever: [],
      ),
    },
  ),
];

// MARK: - Workspace ID
enum _WorkspaceID {
  life("lifeId", "生活", [
    _BigCategoryID.mealPrep,
  ]),
  work("workId", "仕事", [_BigCategoryID.projectA]);

  final String rawValue;
  final String name;
  final List<_BigCategoryID> bigCategories;

  const _WorkspaceID(this.rawValue, this.name, this.bigCategories);
}

// MARK: - BigCategory ID
enum _BigCategoryID {
  // Life
  mealPrep("mealPrepId", "食事の準備", [
    _SmallCategoryID.breakfast,
    _SmallCategoryID.lunch,
    _SmallCategoryID.dinner,
  ]),

  // Work
  projectA("projectAId", "プロジェクトA", []);

  final String rawValue;
  final String name;
  final List<_SmallCategoryID> smallCategories;

  const _BigCategoryID(this.rawValue, this.name, this.smallCategories);
}

// MARK: - SmallCategory ID
enum _SmallCategoryID {
  // Meal Prep
  breakfast("breakfastId", "朝食"),
  lunch("lunchId", "昼食"),
  dinner("dinnerId", "夕食");

  final String rawValue;
  final String name;

  const _SmallCategoryID(this.rawValue, this.name);
}

/// MARK: - ToDoを作成
TLToDo createToDo({
  required _WorkspaceID workspaceID,
  required String categoryID,
  required bool isInToday,
  required String content,
  List<TLStep> steps = const [],
}) {
  return TLToDo(
    id: TLUUIDGenerator.generate(),
    workspaceID: workspaceID.rawValue,
    categoryID: categoryID,
    isInToday: isInToday,
    content: content,
    steps: steps,
  );
}

/// MARK: - Workspaceを作成
TLWorkspace createDefaultWorkspace({
  required _WorkspaceID workspaceID,
  required String workspaceName,
  required List<_BigCategoryID> bigCategoryIDs,
  required Map<_BigCategoryID, List<_SmallCategoryID>> smallCategories,
  required List<TLToDo> todos,
}) {
  return TLWorkspace(
    id: workspaceID.rawValue,
    name: workspaceName,
    bigCategories: bigCategoryIDs
        .map((bigCategory) => TLToDoCategory(
              id: bigCategory.rawValue,
              parentBigCategoryID: null,
              name: bigCategory.name, // enum に name プロパティがない場合は手動で設定
            ))
        .toList(),
    smallCategories: {
      for (var bigCategory in smallCategories.keys)
        bigCategory.rawValue: smallCategories[bigCategory]!
            .map((smallCategory) => TLToDoCategory(
                  id: smallCategory.rawValue,
                  parentBigCategoryID: bigCategory.rawValue,
                  name: smallCategory.name, // enum に name プロパティがない場合は手動で設定
                ))
            .toList()
    },
    categoryIDToToDos: {
      workspaceID.rawValue: TLToDosInTodayAndWhenever(
          categoryID: workspaceID.rawValue,
          toDosInToday: [],
          toDosInWhenever: []),
      for (var bigCategory in bigCategoryIDs)
        bigCategory.rawValue: TLToDosInTodayAndWhenever(
            categoryID: bigCategory.rawValue,
            toDosInToday: [],
            toDosInWhenever: []),
      for (var smallCategoryList in smallCategories.values)
        for (var smallCategory in smallCategoryList)
          smallCategory.rawValue: TLToDosInTodayAndWhenever(
              categoryID: smallCategory.rawValue,
              toDosInToday: [],
              toDosInWhenever: []),
      for (var todo in todos)
        todo.categoryID: TLToDosInTodayAndWhenever(
          categoryID: todo.categoryID,
          toDosInToday: todo.isInToday ? [todo] : [],
          toDosInWhenever: todo.isInToday ? [] : [todo],
        ),
    },
  );
}
