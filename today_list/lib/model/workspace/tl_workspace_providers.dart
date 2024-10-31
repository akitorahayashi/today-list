import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../external/tl_pref.dart';
import './tl_workspace.dart';
import './tl_workspace_notifier.dart';

// TLWorkspacesを提供するProvider
final tlWorkspacesProvider =
    StateNotifierProvider.autoDispose<TLWorkspacesNotifier, List<TLWorkspace>>(
        (ref) {
  return TLWorkspacesNotifier();
});

// currentWorkspaceを提供するProvider
final currentWorkspaceProvider = Provider.autoDispose<TLWorkspace>((ref) {
  final workspaces = ref.watch(tlWorkspacesProvider);
  final selectedIndex = ref.watch(selectedWorkspaceIndexProvider);
  return workspaces[selectedIndex];
});

// currentWorkspaceIndexを提供するProvider
final selectedWorkspaceIndexProvider =
    StateNotifierProvider.autoDispose<CurrentWorkspaceIndexNotifier, int>(
        (ref) {
  return CurrentWorkspaceIndexNotifier();
});

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
