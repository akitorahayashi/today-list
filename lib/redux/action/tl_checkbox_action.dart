import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';

part 'generate/tl_checkbox_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TLCheckBoxAction with _$TLCheckBoxAction {
  // チェックボックスのアイコンを更新
  const factory TLCheckBoxAction.updateSelectedIcon({
    required SelectedCheckBoxIconData newCheckBox,
  }) = _UpdateSelectedIcon;
}
