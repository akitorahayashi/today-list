import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/slidable/slidable_for_workspace_card.dart';

class ChangeWorkspaceCard extends ConsumerWidget {
  final bool isInDrawerList;
  final int indexInWorkspaces;

  const ChangeWorkspaceCard({
    super.key,
    required this.isInDrawerList,
    required this.indexInWorkspaces,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final currentWorkspaceIndex = ref.watch(
        tlAppStateProvider.select((state) => state.currentWorkspaceIndex));
    final workspaceName = ref.watch(tlAppStateProvider
        .select((state) => state.tlWorkspaces[indexInWorkspaces].name));

    final bool isCurrentWorkspace = indexInWorkspaces == currentWorkspaceIndex;

    return Padding(
      padding: EdgeInsets.fromLTRB(5, 1, 5, (!isInDrawerList) ? 5 : 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 70),
        child: Card(
          color: tlThemeData.panelColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: GestureDetector(
              onTap: () => _handleCardTap(context, ref, isCurrentWorkspace),
              child: SlidableForWorkspaceCard(
                isCurrentWorkspace: isCurrentWorkspace,
                indexInTLWorkspaces: indexInWorkspaces,
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 16),
                    child: Text(
                      isCurrentWorkspace && isInDrawerList
                          ? "☆ $workspaceName   "
                          : workspaceName,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: tlThemeData.accentColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MARK - Handle Workspace Selection
  void _handleCardTap(
      BuildContext context, WidgetRef ref, bool isCurrentWorkspace) async {
    if (isCurrentWorkspace) {
      Navigator.pop(context);
    } else {
      final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
      await tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.changeCurrentWorkspaceIndex(indexInWorkspaces),
      );

      // 画面遷移とダイアログの表示
      if (context.mounted) {
        Navigator.pop(context);
        TLSingleOptionDialog(
          title:
              ref.read(tlAppStateProvider).tlWorkspaces[indexInWorkspaces].name,
          message: "に変更しました！",
        ).show(context: context);
      }
    }
  }
}
