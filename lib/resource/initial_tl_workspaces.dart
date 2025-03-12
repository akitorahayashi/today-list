// ignore_for_file: library_private_types_in_public_api
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

enum _TLWorkspaceID {
  work("workId", "Work"),
  life("lifeId", "Life");

  final String rawValue;
  final String name;

  const _TLWorkspaceID(this.rawValue, this.name);
}

final List<TLWorkspace> initialTLWorkspaces = [
  // MARK: - Work Workspace
  TLWorkspace(
    id: _TLWorkspaceID.work.rawValue,
    name: _TLWorkspaceID.work.name,
    workspaceIDToToDos: {
      _TLWorkspaceID.work.rawValue: TLToDosInTodayAndWhenever(
        workspaceID: _TLWorkspaceID.work.rawValue,
        toDosInToday: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _TLWorkspaceID.work.rawValue,
            isInToday: true,
            content: "Aさんとのスケジュールを調整",
          ),
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _TLWorkspaceID.work.rawValue,
            isInToday: true,
            content: "書類の作成",
            steps: [
              TLStep(id: TLUUIDGenerator.generate(), content: "資料を用意する"),
              TLStep(id: TLUUIDGenerator.generate(), content: "送り先に送信する"),
            ],
          ),
        ],
      ),
    },
  ),

  // MARK: - Life Workspace
  TLWorkspace(
    id: _TLWorkspaceID.life.rawValue,
    name: _TLWorkspaceID.life.name,
    workspaceIDToToDos: {
      _TLWorkspaceID.life.rawValue: TLToDosInTodayAndWhenever(
        workspaceID: _TLWorkspaceID.life.rawValue,
        toDosInToday: [
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _TLWorkspaceID.life.rawValue,
            isInToday: true,
            content: "ご飯を炊く",
          ),
          TLToDo(
            id: TLUUIDGenerator.generate(),
            workspaceID: _TLWorkspaceID.life.rawValue,
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
            workspaceID: _TLWorkspaceID.life.rawValue,
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

/// MARK: - ToDoを作成
TLToDo createToDo({
  required String workspaceID,
  required bool isInToday,
  required String content,
  List<TLStep> steps = const [],
}) {
  return TLToDo(
    id: TLUUIDGenerator.generate(),
    workspaceID: workspaceID,
    isInToday: isInToday,
    content: content,
    steps: steps,
  );
}

/// MARK: - Workspaceを作成
TLWorkspace createDefaultWorkspace({
  required _TLWorkspaceID workspaceID,
  required List<TLToDo> todos,
}) {
  return TLWorkspace(
    id: workspaceID.rawValue,
    name: workspaceID.name,
    workspaceIDToToDos: {
      workspaceID.rawValue: TLToDosInTodayAndWhenever(
        workspaceID: workspaceID.rawValue,
        toDosInToday: [],
        toDosInWhenever: [],
      ),
    },
  );
}
