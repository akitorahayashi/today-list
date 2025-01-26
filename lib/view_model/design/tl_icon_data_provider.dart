import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/resource/tl_icon_resource.dart';
import '../../service/tl_pref.dart';
import '../../model/design/tl_icon_data.dart';
import 'dart:convert';

final tlIconDataProvider =
    StateNotifierProvider<TLIconDataNotifier, TLIconData>(
  (ref) => TLIconDataNotifier(),
);

class TLIconDataNotifier extends StateNotifier<TLIconData> {
  TLIconDataNotifier()
      : super(
          TLIconData(
            category: TLIconCategory.defaultCategory,
            rarity: TLIconRarity.common,
            name: TLIconName.box,
          ),
        ) {
    _loadSelectedIconData();
  }

  /// 選択したアイコンの情報を取得する
  TLIconForCheckBox? getSelectedIcon() {
    return tlIconResource[state.category]?[state.rarity]?[state.name];
  }

  /// 選択しているアイコンの情報を更新する
  Future<void> updateSelectedIcon(TLIconData newIconData) async {
    state = newIconData;
    await _saveSelectedIconData();
  }

  /// 選択したアイコンのデータを保存する
  Future<void> _saveSelectedIconData() async {
    final prefs = await TLPrefService().getPref;
    final jsonString = jsonEncode(state.toJson());
    await prefs.setString('selectedIconData', jsonString);
  }

  /// 選択したアイコンのデータをロードする
  Future<void> _loadSelectedIconData() async {
    final prefs = await TLPrefService().getPref;
    final jsonString = prefs.getString('selectedIconData');
    if (jsonString != null) {
      final jsonData = jsonDecode(jsonString);
      state = TLIconData.fromJson(jsonData);
    }
  }
}
