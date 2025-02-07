import 'package:freezed_annotation/freezed_annotation.dart';
import 'tl_category.dart';
import 'tl_todos_in_today_and_whenever.dart';

part '../generate/tl_workspace.freezed.dart';
part '../generate/tl_workspace.g.dart';

// $ dart run build_runner build

@freezed
class TLWorkspace with _$TLWorkspace {
  factory TLWorkspace({
    required String id,
    required String name,
    required List<TLCategory> bigCategories,
    required Map<String, List<TLCategory>> smallCategories,
    required Map<String, TLToDosInTodayAndWhenever> categoryIDToToDos,
  }) = _TLWorkspace;

  factory TLWorkspace.fromJson(Map<String, dynamic> json) =>
      _$TLWorkspaceFromJson(json);
}
