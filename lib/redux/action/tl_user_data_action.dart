import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part 'generate/tl_user_data_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLUserDataAction with _$TLUserDataAction {
  // アプリのアイコンを変更
  const factory TLUserDataAction.updateCurrentAppIconName({
    required String newThemeName,
  }) = _UpdateCurrentAppIconType;

  // チェックボックスのアイコンを更新
  const factory TLUserDataAction.updateSelectedCheckBoxIcon({
    required SelectedCheckBoxIconData newCheckBox,
  }) = _UpdateSelectedCheckBoxIcon;
}
