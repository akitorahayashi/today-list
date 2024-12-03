import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_list/model/external/tl_method_channel.dart';

final selectedThemeIndexProvider =
    StateNotifierProvider<SelectedThemeIndexNotifier, int>(
  (ref) => SelectedThemeIndexNotifier(),
);

class SelectedThemeIndexNotifier extends StateNotifier<int> {
  SelectedThemeIndexNotifier() : super(0) {
    _loadInitialThemeIndex();
  }

  Future<void> _loadInitialThemeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('selectedThemeIndex') ?? 0;
    state = index;
  }

  void changeThemeIndex(int index) async {
    state = index;
    final prefs = await SharedPreferences.getInstance();
    TLMethodChannel.updateSelectedTheme(selectedThemeIndex: index);
    prefs.setInt('selectedThemeIndex', index);
  }
}
