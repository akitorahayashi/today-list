import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part 'generate/tl_theme_action.freezed.dart';

// $ dart run build_runner build

@freezed
class TLThemeAction with _$TLThemeAction {
  const factory TLThemeAction.changeTheme({
    required TLThemeType themeType,
  }) = ChangeThemeAction;
}
