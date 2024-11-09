import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/dialog/common/single_option_dialog.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/external/tl_vibration.dart';
import '../../../model/tl_workspace.dart';
import '../../../model/provider/tl_workspaces_provider.dart';
import '../../../model/design/tl_theme.dart';
import '../../../components/slidables/slidable_for_workspace_card.dart';

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
    final List<TLWorkspace> tlWorkspaces = ref.watch(tlWorkspacesProvider);
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final CurrentTLWorkspaceNotifier currentTLWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
    // other
    final int currentTLWorkspaceIndex =
        currentTLWorkspaceNotifier.currentTLWorkspaceIndex;
    final bool isCurrentWorkspace =
        indexInWorkspaces == currentTLWorkspaceIndex;
    return Padding(
      padding: EdgeInsets.fromLTRB(
          5, 1, 5, (isCurrentWorkspace && !isInDrawerList) ? 5 : 0),
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
                    currentTLWorkspaceNotifier.changeCurrentWorkspaceIndex(
                        newCurrentWorkspaceIndex: indexInWorkspaces);
                    TLVibration.vibrate();
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (context) => TLSingleOptionDialog(
                            title: currentTLWorkspace.name,
                            message: "workspaceを変更しました！"));
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
