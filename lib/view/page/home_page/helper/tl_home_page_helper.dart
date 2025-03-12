import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/action/current_workspace_action.dart';
import 'package:today_list/flux/dispatcher/current_workspace_dispatcher.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';

/// HomePage専用のヘルパークラス
/// TabController関連の処理を集約
class TLHomePageHelper {
  /// タブインデックスが変更されたときの共通処理（+タブ含む）
  static void handleTabIndexChange({
    required int index,
    required BuildContext context,
    required WidgetRef ref,
    required TabController? tabController,
    required int previousIndex,
    required Function(int) updatePreviousIndex,
  }) async {
    final workspacesAsync = await ref.read(workspacesProvider.future);
    final plusTabIndex = workspacesAsync.length + 1;

    // +タブが押された場合
    if (index == plusTabIndex) {
      if (context.mounted) {
        const AddOrEditWorkspaceDialog(
          oldWorkspaceId: null,
        ).show(context: context);
      }

      // 「+」タブを押したらダイアログ後、前のタブに戻す
      tabController?.index = previousIndex;
      return;
    }

    // 前回のインデックスを更新
    updatePreviousIndex(index);

    // 0 番目タブ -> Today
    // 1 番目以降 -> Workspace
    final newWorkspaceID =
        (index == 0) ? null : workspacesAsync.elementAtOrNull(index - 1)?.id;

    await CurrentWorkspaceDispatcher.dispatch(
      ref,
      CurrentWorkspaceAction.setCurrentWorkspaceId(newWorkspaceID),
    );
  }

  /// 現在の Workspace (null の可能性あり)を取得
  static Future<TLWorkspace?> getCurrentWorkspace(WidgetRef ref) async {
    final currentIDAsync = await ref.read(currentWorkspaceIdProvider.future);
    if (currentIDAsync == null) return null;

    final workspacesAsync = await ref.read(workspacesProvider.future);
    final filteredList = workspacesAsync.where((ws) => ws.id == currentIDAsync);
    return filteredList.isNotEmpty ? filteredList.first : null;
  }

  /// ページタイトルを取得
  static Future<String> getPageTitle(WidgetRef ref, int currentTabIndex) async {
    // TabController が無い場合のために fallback: 0 (Today)
    final index = currentTabIndex;
    if (index == 0) return "Today List";

    final currentWorkspace = await getCurrentWorkspace(ref);
    return currentWorkspace?.name ?? "Today List";
  }

  /// 初期タブインデックスを計算
  static Future<int> calculateInitialIndex(WidgetRef ref) async {
    final currentIDAsync = await ref.read(currentWorkspaceIdProvider.future);
    final workspacesAsync = await ref.read(workspacesProvider.future);

    final currentWsIndex = workspacesAsync.indexWhere(
      (ws) => ws.id == currentIDAsync,
    );
    return (currentWsIndex == -1) ? 0 : currentWsIndex + 1;
  }

  /// +タブへのスクロールを防止するカスタムスクロールフィジックス
  static ScrollPhysics createCustomTabBarScrollPhysics({
    required int plusTabIndex,
    ScrollPhysics? parent = const ClampingScrollPhysics(),
  }) {
    return _CustomTabBarScrollPhysics(
      plusTabIndex: plusTabIndex,
      parent: parent,
    );
  }
}

/// +タブへのスクロールを防止するカスタムスクロールフィジックス
/// HomePageでのみ使用する
class _CustomTabBarScrollPhysics extends ScrollPhysics {
  final int plusTabIndex;

  const _CustomTabBarScrollPhysics({required this.plusTabIndex, super.parent});

  @override
  _CustomTabBarScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return _CustomTabBarScrollPhysics(
      plusTabIndex: plusTabIndex,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // 現在のページインデックスを計算
    final int currentPage = position.pixels ~/ position.viewportDimension;

    // +タブの直前のページで右へのスクロールを試みている場合
    if (currentPage == plusTabIndex - 1 && offset > 0) {
      return 0.0; // スクロールを無効化
    }

    return super.applyPhysicsToUserOffset(position, offset);
  }
}
