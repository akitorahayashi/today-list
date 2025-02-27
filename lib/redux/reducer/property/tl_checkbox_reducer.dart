import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/redux/action/tl_checkbox_action.dart';

class TLCheckBoxReducer {
  static SelectedCheckBoxIconData reduce(
      SelectedCheckBoxIconData state, TLCheckBoxAction action) {
    return action.map(
      updateSelectedIcon: (a) => _updateSelectedCheckBox(state, a.newCheckBox),
    );
  }

  // チェックボックスデータを更新
  static SelectedCheckBoxIconData _updateSelectedCheckBox(
      SelectedCheckBoxIconData state,
      SelectedCheckBoxIconData newCheckBoxData) {
    return newCheckBoxData;
  }
}
