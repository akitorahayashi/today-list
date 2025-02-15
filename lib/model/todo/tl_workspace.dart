import 'package:freezed_annotation/freezed_annotation.dart';
import 'tl_todo_category.dart';
import 'tl_todos_in_today_and_whenever.dart';

part '../generate/tl_workspace.freezed.dart';
part '../generate/tl_workspace.g.dart';

// $ dart run build_runner build

@freezed
class TLWorkspace with _$TLWorkspace {
  factory TLWorkspace({
    required String id,
    required String name,
    required List<TLToDoCategory> bigCategories,
    required Map<String, List<TLToDoCategory>> smallCategories,
    required Map<String, TLToDosInTodayAndWhenever> categoryIDToToDos,
  }) = _TLWorkspace;

  factory TLWorkspace.fromJson(Map<String, dynamic> json) =>
      _$TLWorkspaceFromJson(json);
}
