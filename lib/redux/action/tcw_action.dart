import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:today_list/model/settings_data/tcw_settings.dart';

part 'generate/tcw_action.freezed.dart';

// $ dart run build_runner build

@freezed
sealed class TCWSettingsAction with _$TCWSettingsAction {
  // 設定を追加
  const factory TCWSettingsAction.addTCWSetting({
    required TCWSettings newSettings,
  }) = _AddTCWSetting;

  // 設定を削除
  const factory TCWSettingsAction.removeTCWSetting({
    required String id,
  }) = _RemoveTCWSetting;

  // 設定リストを更新
  const factory TCWSettingsAction.updateTCWSettingsList({
    required List<TCWSettings> updatedList,
  }) = _UpdateTCWSettingsList;
}
