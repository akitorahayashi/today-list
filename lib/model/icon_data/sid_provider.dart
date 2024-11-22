import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/tl_pref.dart';
import 'selected_icon_data.dart';
import 'dart:convert';

final tlIconDataProvider =
    StateNotifierProvider<TLIconDataNotifier, TLIconData>(
  (ref) => TLIconDataNotifier(),
);

class TLIconDataNotifier extends StateNotifier<TLIconData> {
  TLIconDataNotifier()
      : super(TLIconData(
          category: 'Default',
          rarity: 'Common',
          name: 'box',
        )) {
    _loadSelectedIconData();
  }

  Future<void> setSelectedIconData(
      String category, String rarity, String name) async {
    state = state.copyWith(category: category, rarity: rarity, name: name);
    await _saveSelectedIconData();
  }

  Future<void> _saveSelectedIconData() async {
    final prefs = await TLPref().getPref;
    final jsonString = json.encode(state.toJson());
    await prefs.setString('selectedIconData', jsonString);
  }

  Future<void> _loadSelectedIconData() async {
    final prefs = await TLPref().getPref;
    final jsonString = prefs.getString('selectedIconData');
    if (jsonString != null) {
      final jsonData = json.decode(jsonString);
      state = TLIconData.fromJson(jsonData);
    }
  }
}
