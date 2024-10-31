import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/tl_pref.dart';
import './tl_workspace.dart';
import './tl_workspaces_provider.dart';

// currentWorkspaceを提供するProvider
final currentWorkspaceProvider = Provider.autoDispose<TLWorkspace>((ref) {
  final _tlWorkspaces = ref.watch(tlWorkspacesProvider);
  final _correntIndex = ref.watch(selectedWorkspaceIndexProvider);
  return _tlWorkspaces[_correntIndex];
});

// currentWorkspaceIndexを提供するProvider
final selectedWorkspaceIndexProvider =
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

  Future<void> setCurrentWorkspaceIndex(int newIndex) async {
    state = newIndex;
    await TLPref().getPref.then((pref) {
      pref.setInt('currentWorkspaceIndex', newIndex);
    });
  }
}
