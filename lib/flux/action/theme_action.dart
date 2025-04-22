import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part 'generate/theme_action.freezed.dart';

// $ dart run build_runner build

@freezed
class ThemeAction with _$ThemeAction {
  const factory ThemeAction.changeTheme({required TLThemeType newThemeType}) =
      ChangeThemeAction;
}
