import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/selected_check_box_icon_data.freezed.dart';
part '../generate/selected_check_box_icon_data.g.dart';

// $ dart run build_runner build

@freezed
class SelectedCheckBoxIconData with _$SelectedCheckBoxIconData {
  const factory SelectedCheckBoxIconData({
    required String iconCategory,
    required String iconName,
  }) = _SelectedCheckBoxIconData;

  factory SelectedCheckBoxIconData.fromJson(Map<String, dynamic> json) =>
      _$SelectedCheckBoxIconDataFromJson(json);
}
