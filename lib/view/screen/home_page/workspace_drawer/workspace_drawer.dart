import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/common_ui_part/tl_sliver_appbar.dart';
import 'change_workspace_card.dart';
import 'add_workspace_button.dart';

class TLWorkspaceDrawer extends ConsumerWidget {
  final bool isContentMode;
  const TLWorkspaceDrawer({super.key, required this.isContentMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final currentTLWorkspaceIndex = ref.watch(
      tlAppStateProvider.select((state) => state.currentWorkspaceIndex),
    );
    final workspaces = ref.watch(
      tlAppStateProvider.select((state) => state.tlWorkspaces),
    );

    return Drawer(
      child: Stack(
        children: [
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              _buildAppBar(),
              _buildWorkspaceList(
                  context, ref, currentTLWorkspaceIndex, workspaces),
            ],
          ),
        ],
      ),
    );
  }

  // MARK - AppBar
  Widget _buildAppBar() {
    return TLSliverAppBar(
      pageTitle: "Workspace",
      leadingButtonOnPressed: null,
      leadingIcon: Container(),
      trailingButtonOnPressed: null,
      trailingIcon: null,
    );
  }

  // MARK - Workspace List
  Widget _buildWorkspaceList(BuildContext context, WidgetRef ref,
      int currentWorkspaceIndex, List<TLWorkspace> workspaces) {
    final TLThemeData tlThemeData = TLTheme.of(context);

    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: _buildOtherWorkspacesSection(
              context, ref, currentWorkspaceIndex, workspaces, tlThemeData),
        ),
      ]),
    );
  }

  // MARK - Other Workspaces Section
  Widget _buildOtherWorkspacesSection(
      BuildContext context,
      WidgetRef ref,
      int currentWorkspaceIndex,
      List<TLWorkspace> workspaces,
      TLThemeData tlThemeData) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: tlThemeData.panelBorderColor),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 3.0),
            child: Column(
              children: [
                const ChangeWorkspaceCard(indexInWorkspaces: 0),
                _buildReorderableWorkspaceList(
                    ref, currentWorkspaceIndex, workspaces),
                const AddWorkspaceButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // MARK - Reorderable Workspace List
  Widget _buildReorderableWorkspaceList(
      WidgetRef ref, int currentWorkspaceIndex, List<TLWorkspace> workspaces) {
    return ReorderableColumn(
      children: [
        for (int i = 1; i < workspaces.length; i++)
          ChangeWorkspaceCard(
            key: ValueKey(workspaces[i].id),
            indexInWorkspaces: i,
          ),
      ],
      onReorder: (oldIndex, newIndex) {
        _handleReorder(ref, oldIndex, newIndex, currentWorkspaceIndex);
      },
    );
  }

  // MARK - Handle Reordering Logic
  void _handleReorder(
      WidgetRef ref, int oldIndex, int newIndex, int currentWorkspaceIndex) {
    if (newIndex == oldIndex) return;

    final revisedOldIndex = oldIndex + 1;
    final revisedNewIndex = newIndex + 1;

    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    final workspaces = ref.read(tlAppStateProvider).tlWorkspaces;

    List<TLWorkspace> copiedWorkspaces = List.from(workspaces);
    final TLWorkspace movedWorkspace =
        copiedWorkspaces.removeAt(revisedOldIndex);
    copiedWorkspaces.insert(revisedNewIndex, movedWorkspace);

    if (revisedOldIndex == currentWorkspaceIndex) {
      tlAppStateReducer.dispatchWorkspaceAction(
          ChangeCurrentWorkspaceIndex(revisedNewIndex));
    } else if (revisedOldIndex < currentWorkspaceIndex &&
        revisedNewIndex >= currentWorkspaceIndex) {
      tlAppStateReducer.dispatchWorkspaceAction(
          ChangeCurrentWorkspaceIndex(currentWorkspaceIndex - 1));
    } else if (revisedOldIndex > currentWorkspaceIndex &&
        revisedNewIndex <= currentWorkspaceIndex) {
      tlAppStateReducer.dispatchWorkspaceAction(
          ChangeCurrentWorkspaceIndex(currentWorkspaceIndex + 1));
    }

    tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.updateWorkspaceList(copiedWorkspaces));
  }
}
