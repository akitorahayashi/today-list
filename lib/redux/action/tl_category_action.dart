import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';

part 'generate/tl_category_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLCategoryAction with _$TLCategoryAction {
  /// 新規のカテゴリーを追加する
  const factory TLCategoryAction.addCategory({
    required String workspaceID,
    required TLToDoCategory category,
  }) = _AddCategory;

  /// 既存のカテゴリーを更新する
  const factory TLCategoryAction.updateCategory({
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) = _UpdateCategory;

  /// 既存のカテゴリーを削除する
  const factory TLCategoryAction.removeCategory({
    required String workspaceID,
    required TLToDoCategory newCategory,
  }) = _RemoveCategory;
}
