// ignore_for_file: library_private_types_in_public_api
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

enum _TLWorkspaceID {
  general("generalId", "General");

  final String rawValue;
  final String name;

  const _TLWorkspaceID(this.rawValue, this.name);
}

final List<TLWorkspace> initialTLWorkspaces = [
  // MARK: - General Workspace
  TLWorkspace(
    id: _TLWorkspaceID.general.rawValue,
    name: _TLWorkspaceID.general.name,
    toDos: TLToDosInTodayAndWhenever(
      workspaceID: _TLWorkspaceID.general.rawValue,
      toDosInToday: [
        TLToDo(
          id: TLUUIDGenerator.generate(),
          workspaceID: _TLWorkspaceID.general.rawValue,
          isInToday: true,
          content: "Aさんとのスケジュールを調整",
        ),
        TLToDo(
          id: TLUUIDGenerator.generate(),
          workspaceID: _TLWorkspaceID.general.rawValue,
          isInToday: true,
          content: "書類の作成",
          steps: [
            TLStep(id: TLUUIDGenerator.generate(), content: "資料を用意する"),
            TLStep(id: TLUUIDGenerator.generate(), content: "送り先に送信する"),
          ],
        ),
        TLToDo(
          id: TLUUIDGenerator.generate(),
          workspaceID: _TLWorkspaceID.general.rawValue,
          isInToday: false,
          content: "来月の旅行計画",
          steps: [
            TLStep(id: TLUUIDGenerator.generate(), content: "宿を予約する"),
            TLStep(id: TLUUIDGenerator.generate(), content: "交通手段を調べる"),
          ],
        ),
      ],
      toDosInWhenever: [],
    ),
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
    toDos: TLToDosInTodayAndWhenever(
      workspaceID: workspaceID.rawValue,
      toDosInToday: [],
      toDosInWhenever: [],
    ),
  );
}
