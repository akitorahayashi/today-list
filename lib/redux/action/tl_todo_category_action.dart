import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';

part 'generate/tl_todo_category_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLToDoCategoryAction with _$TLToDoCategoryAction {
  /// 新規のカテゴリーを追加する
  const factory TLToDoCategoryAction.addCategory({
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) = _AddCategory;

  /// 既存のカテゴリーを更新する
  const factory TLToDoCategoryAction.updateCategory({
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) = _UpdateCategory;

  /// 既存のカテゴリーを削除する
  const factory TLToDoCategoryAction.deleteCategory({
    required TLWorkspace corrWorkspace,
    required TLToDoCategory categoryToDelete,
  }) = _RemoveCategory;
}
