import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/tl_category.freezed.dart';
part '../generate/tl_category.g.dart';

@freezed
class TLCategory with _$TLCategory {
  const factory TLCategory({
    required String id,
    required String title,
  }) = _TLCategory;

  // JSON用メソッドは自動生成される
  factory TLCategory.fromJson(Map<String, dynamic> json) =>
      _$TLCategoryFromJson(json);
}
