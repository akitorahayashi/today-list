import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/tl_todo_category.freezed.dart';
part '../generate/tl_todo_category.g.dart';

// $ dart run build_runner build

@freezed
class TLToDoCategory with _$TLToDoCategory {
  const factory TLToDoCategory({
    required String id,
    required String? parentBigCategoryID,
    required String name,
  }) = _TLToDoCategory;

  factory TLToDoCategory.fromJson(Map<String, dynamic> json) =>
      _$TLToDoCategoryFromJson(json);
}
