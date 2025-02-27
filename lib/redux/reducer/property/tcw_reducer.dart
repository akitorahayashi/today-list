import 'package:today_list/model/settings_data/tcw_settings.dart';
import 'package:today_list/redux/action/tcw_action.dart';

class TCWSettingsReducer {
  static List<TCWSettings> reduce(
    List<TCWSettings> state,
    TCWSettingsAction action,
  ) {
    return action.map(
      addTCWSetting: (a) => _addTCWSetting(state, a.newSettings),
      removeTCWSetting: (a) => _removeTCWSetting(state, a.id),
      updateTCWSettingsList: (a) =>
          _updateTCWSettingsList(state, a.updatedList),
    );
  }

  // 設定を追加
  static List<TCWSettings> _addTCWSetting(
    List<TCWSettings> state,
    TCWSettings newSetting,
  ) {
    return [...state, newSetting];
  }

  // 設定を削除
  static List<TCWSettings> _removeTCWSetting(
    List<TCWSettings> state,
    String id,
  ) {
    return state.where((element) => element.id != id).toList();
  }

  // 設定リストを更新
  static List<TCWSettings> _updateTCWSettingsList(
    List<TCWSettings> state,
    List<TCWSettings> updatedList,
  ) {
    return updatedList;
  }
}
