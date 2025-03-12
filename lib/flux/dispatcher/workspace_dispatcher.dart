import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/action/workspace_action.dart';
import 'package:today_list/flux/store/workspace_store.dart';

/// ワークスペース関連のディスパッチャー
class WorkspaceDispatcher {
  /// ワークスペース関連のアクションをディスパッチします
  static Future<void> dispatch(WidgetRef ref, WorkspaceAction action) async {
    await action.map(
      addWorkspace: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .addWorkspace(action.newWorkspace);
      },
      updateWorkspace: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .updateWorkspace(action.workspace);
      },
      deleteWorkspace: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .deleteWorkspace(action.workspaceId);
      },
      deleteAllCheckedToDosInWorkspace: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .deleteAllCheckedToDosInWorkspace(action.workspace);
      },
      reorderWorkspace: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .reorderWorkspace(action.oldIndex, action.newIndex);
      },
      deleteAllCheckedToDosInToday: (action) async {
        await ref
            .read(workspacesProvider.notifier)
            .deleteAllCheckedToDosInTodayInWorkspaceList(action.workspaces);
      },
    );
  }
}
