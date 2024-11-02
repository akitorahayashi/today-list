import 'package:today_list/model/external/tl_pref.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// currentWorkspaceIndexを提供するProvider
final currentWorkspaceIndexProvider =
    StateNotifierProvider.autoDispose<CurrentWorkspaceIndexNotifier, int>(
        (ref) {
  return CurrentWorkspaceIndexNotifier();
});

// currentWorkspaceIndexを管理するNotifier
class CurrentWorkspaceIndexNotifier extends StateNotifier<int> {
  CurrentWorkspaceIndexNotifier() : super(0) {
    // コンストラクタ
    TLPref().getPref.then((pref) {
      final initialIndex = pref.getInt('currentWorkspaceIndex') ?? 0;
      state = initialIndex;
    });
  }

  Future<void> changeCurrentWorkspaceIndex(int newIndex) async {
    state = newIndex;
    await TLPref().getPref.then((pref) {
      pref.setInt('currentWorkspaceIndex', newIndex);
    });
  }
}
