import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/resource/tl_theme_type.dart';

part '../generate/settings_data.freezed.dart';
part '../generate/settings_data.g.dart';

// $ dart run build_runner build

@freezed
class SettingsData with _$SettingsData {
  const factory SettingsData({
    @Default('sunOrange') String currentAppIconName,
  }) = _SettingsData;

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);
}
