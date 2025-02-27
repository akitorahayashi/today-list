import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/resource/icon_resource_of_checkbox.dart';

part '../generate/tl_user_data.freezed.dart';
part '../generate/tl_user_data.g.dart';

// $ dart run build_runner build

@freezed
class TLUserData with _$TLUserData {
  const factory TLUserData({
    // 現在のアプリアイコンの名前
    @Default("Sun Orange") String currentAppIconName,
    // 選択されたチェックボックスのアイコン
    @Default(SelectedCheckBoxIconData(iconCategory: "Default", iconName: "Box"))
    SelectedCheckBoxIconData selectedCheckBoxIconData,
    // 獲得したチェックボックスのアイコン
    @Default({
      "Default": ["Box", "Circle"]
    })
    Map<String, List<String>> earnedCheckBoxIcons,
  }) = _TLUserData;

  factory TLUserData.fromJson(Map<String, dynamic> json) =>
      _$TLUserDataFromJson(json);
}
