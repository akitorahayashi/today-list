import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';

part '../generate/tl_user_data.freezed.dart';
part '../generate/tl_user_data.g.dart';

// $ dart run build_runner build

@freezed
class TLUserData with _$TLUserData {
  const factory TLUserData({
    @Default("Sun Orange") String currentAppIconName,
    @Default(SelectedCheckBoxIconData(iconCategory: "Default", iconName: "Box"))
    SelectedCheckBoxIconData selectedCheckBoxIconData,
  }) = _TLUserData;

  factory TLUserData.fromJson(Map<String, dynamic> json) =>
      _$TLUserDataFromJson(json);
}
