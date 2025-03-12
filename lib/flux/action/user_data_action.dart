import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

part 'generate/user_data_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class UserDataAction with _$UserDataAction {
  // アプリのアイコンを変更
  const factory UserDataAction.updateCurrentAppIconName({
    required String newThemeName,
  }) = UpdateCurrentAppIconType;

  // チェックボックスのアイコンを更新
  const factory UserDataAction.updateSelectedCheckBoxIcon({
    required SelectedCheckBoxIconData newCheckBox,
  }) = UpdateSelectedCheckBoxIcon;

  // 獲得したアイコンを更新
  const factory UserDataAction.updateEarnedIcons({
    required TLIconCategory iconCategory,
    required TLIconName iconName,
  }) = UpdateEarnedIcons;
}
