import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';

part '../generate/tl_todo_category.freezed.dart';
part '../generate/tl_todo_category.g.dart';

// $ dart run build_runner build

@freezed
class TLToDoCategory with _$TLToDoCategory {
  const TLToDoCategory._();

  const factory TLToDoCategory({
    required String id,
    required String? parentBigCategoryID,
    required String name,
  }) = _TLToDoCategory;

  factory TLToDoCategory.fromJson(Map<String, dynamic> json) =>
      _$TLToDoCategoryFromJson(json);

  int getNumberOfToDosInThisCategory({
    required bool? ifInToday,
    required TLToDosInTodayAndWhenever corrToDos,
  }) {
    if (ifInToday == null) {
      final int count =
          corrToDos.getToDos(true).length + corrToDos.getToDos(false).length;
      return count;
    } else {
      final int count = corrToDos.getToDos(ifInToday).length;
      return count;
    }
  }
}
