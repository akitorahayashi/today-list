import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/action/current_workspace_action.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';

/// 現在のワークスペースID関連のディスパッチャー
class CurrentWorkspaceDispatcher {
  /// 現在のワークスペースID関連のアクションをディスパッチします
  static Future<void> dispatch(
    WidgetRef ref,
    CurrentWorkspaceAction action,
  ) async {
    await action.map(
      setCurrentWorkspaceId: (action) async {
        await ref
            .read(currentWorkspaceIdProvider.notifier)
            .setCurrentWorkspaceId(action.workspaceId);
      },
    );
  }
}
