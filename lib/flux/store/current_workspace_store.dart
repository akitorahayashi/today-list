import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 現在のワークスペースIDを管理するプロバイダー
final currentWorkspaceIdProvider =
    AsyncNotifierProvider<CurrentWorkspaceIdNotifier, String?>(
      CurrentWorkspaceIdNotifier.new,
    );

/// 現在のワークスペースIDを管理するNotifier
class CurrentWorkspaceIdNotifier extends AsyncNotifier<String?> {
  static const String _currentWorkspaceIdKey = 'current_workspace_id';

  @override
  Future<String?> build() async {
    return _loadCurrentWorkspaceId();
  }

  /// 現在のワークスペースIDを読み込みます
  Future<String?> _loadCurrentWorkspaceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentWorkspaceIdKey);
  }

  /// 現在のワークスペースIDを設定します
  Future<void> setCurrentWorkspaceId(String? workspaceId) async {
    final prefs = await SharedPreferences.getInstance();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<String?>.loading().copyWithPrevious(state);

    try {
      if (workspaceId == null) {
        await prefs.remove(_currentWorkspaceIdKey);
      } else {
        await prefs.setString(_currentWorkspaceIdKey, workspaceId);
      }

      // 成功したら新しい状態を設定
      state = AsyncValue<String?>.data(workspaceId);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<String?>.error(e, stack).copyWithPrevious(state);
    }
  }
}
