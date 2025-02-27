import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/tcw_settings.freezed.dart';
part '../generate/tcw_settings.g.dart';

// $ dart run build_runner build

@freezed
class TCWSettings with _$TCWSettings {
  const factory TCWSettings({
    required String id,
    required String title,
    required TLWorkspace workspace,
    required TLToDoCategory? bigCategory,
    required TLToDoCategory? smallCategory,
  }) = _TCWSettings;

  factory TCWSettings.fromJson(Map<String, dynamic> json) =>
      _$TCWSettingsFromJson(json);
}
