import 'package:freezed_annotation/freezed_annotation.dart';
import 'tl_todos_in_today_and_whenever.dart';

part '../generate/tl_workspace.freezed.dart';
part '../generate/tl_workspace.g.dart';

// $ dart run build_runner build

@freezed
class TLWorkspace with _$TLWorkspace {
  const TLWorkspace._();

  factory TLWorkspace({
    required String id,
    required String name,
    required TLToDosInTodayAndWhenever toDos,
  }) = _TLWorkspace;

  factory TLWorkspace.fromJson(Map<String, dynamic> json) =>
      _$TLWorkspaceFromJson(json);

  int getNumOfToDoInWorkspace({required bool ifInToday}) {
    int todoCount = 0;

    todoCount += toDos.getToDos(ifInToday).length;

    return todoCount;
  }
}
