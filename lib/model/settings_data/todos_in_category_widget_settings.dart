import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/todos_in_category_widget_settings.freezed.dart';
part '../generate/todos_in_category_widget_settings.g.dart';

// $ dart run build_runner build

@freezed
class ToDosInCategoryWidgetSettings with _$ToDosInCategoryWidgetSettings {
  const factory ToDosInCategoryWidgetSettings({
    required String id,
    required String title,
    required TLWorkspace workspace,
    required TLToDoCategory bigCategory,
    required TLToDoCategory? smallCategory,
  }) = _ToDosInCategoryWidgetSettings;

  factory ToDosInCategoryWidgetSettings.fromJson(Map<String, dynamic> json) =>
      _$ToDosInCategoryWidgetSettingsFromJson(json);
}
