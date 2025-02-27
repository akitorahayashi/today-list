import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/tcw_settings.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part 'generate/tl_app_state.freezed.dart';
part 'generate/tl_app_state.g.dart';

// $ dart run build_runner build

@freezed
class TLAppState with _$TLAppState {
  const TLAppState._();

  const factory TLAppState({
    @Default([]) List<TLWorkspace> tlWorkspaces,
    @Default(null) String? currentWorkspaceID,
    @Default(TLThemeType.sunOrange) TLThemeType selectedThemeType,
    @Default([]) List<TCWSettings> tcwSettings,
  }) = _TLAppState;

  factory TLAppState.fromJson(Map<String, dynamic> json) =>
      _$TLAppStateFromJson(json);
}
