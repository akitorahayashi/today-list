import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/tl_category.freezed.dart';
part '../generate/tl_category.g.dart';

// $ dart run build_runner build

@freezed
class TLCategory with _$TLCategory {
  static const String noneID = "defaultID";

  const factory TLCategory({
    required String id,
    required String title,
  }) = _TLCategory;

  factory TLCategory.fromJson(Map<String, dynamic> json) =>
      _$TLCategoryFromJson(json);
}
