import 'package:freezed_annotation/freezed_annotation.dart';

part '../generate/setting_data.freezed.dart';
part '../generate/setting_data.g.dart';

// $ dart run build_runner build

@freezed
class SettingsData with _$SettingData {
  const factory SettingsData({
    @Default("Sun Orange") String currentAppIconName,
  }) = _SettingData;

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingDataFromJson(json);
}
