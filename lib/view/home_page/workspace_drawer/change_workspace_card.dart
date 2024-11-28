import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/workspace/tl_workspaces_state.dart';
import '../../../component/dialog/common/tl_single_option_dialog.dart';
import '../../../model/external/tl_vibration.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../model/tl_theme.dart';
import '../../../component/slidable/slidable_for_workspace_card.dart';

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
    // provider
    final tlWorkspacesState = ref.watch(tlWorkspacesStateProvider);
    final List<TLWorkspace> tlWorkspaces = tlWorkspacesState.tlWorkspaces;
    final TLWorkspace currentTLWorkspace = tlWorkspacesState.currentWorkspace;
    // notifier
    final tlWorkspacesStateNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    // other
    final int currentTLWorkspaceIndex = tlWorkspacesState.currentWorkspaceIndex;
    final bool isCurrentWorkspace =
        indexInWorkspaces == currentTLWorkspaceIndex;
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
                onTap: () async {
                  if (isCurrentWorkspace) {
                    Navigator.pop(context);
                  } else {
                    await tlWorkspacesStateNotifier
                        .changeCurrentWorkspaceIndex(indexInWorkspaces);
                    TLVibration.vibrate();
                    if (context.mounted) {
                      Navigator.pop(context);
                      TLSingleOptionDialog(
                              title: tlWorkspaces[indexInWorkspaces].name,
                              message: "に変更しました！")
                          .show(context: context);
                    }
                  }
                },
                child: SlidableForWorkspaceCard(
                  isCurrentWorkspace: isCurrentWorkspace,
                  indexInTLWorkspaces: indexInWorkspaces,
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: Text(
                          isCurrentWorkspace && isInDrawerList
                              ? ("☆ ${currentTLWorkspace.name}   ")
                              : tlWorkspaces[indexInWorkspaces].name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: tlThemeData.accentColor,
                              letterSpacing: 1)),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
