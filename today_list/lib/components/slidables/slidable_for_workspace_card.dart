import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import '../../components/dialog/for_workspace/delete_workspace_dialog.dart';
import '../../model/tl_workspace.dart';
import '../../model/provider/tl_workspaces_provider.dart';
import '../../model/design/tl_theme.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForWorkspaceCard extends ConsumerWidget {
  final bool isCurrentWorkspace;
  final int indexInTLWorkspaces;
  final Widget child;
  const SlidableForWorkspaceCard({
    super.key,
    required this.isCurrentWorkspace,
    required this.indexInTLWorkspaces,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final List<TLWorkspace> _tlWorkspaces = ref.watch(tlWorkspacesProvider);
    // other
    final TLWorkspace _corrWorkspace = _tlWorkspaces[indexInTLWorkspaces];
    return Slidable(
      // currentWorkspaceの時や
      startActionPane: isCurrentWorkspace ||
              // デフォルトワークスペースの時は削除できないようにする
              indexInTLWorkspaces == 0
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.35,
              children: [
                // For deleting workspace
                SlidableAction(
                  autoClose: true,
                  spacing: 8,
                  backgroundColor: _tlThemeData.panelColor,
                  foregroundColor: _tlThemeData.accentColor,
                  onPressed: (BuildContext context) async {
                    await showDialog(
                        context: context,
                        builder: (context) => DeleteWorkspaceDialog(
                            corrWorkspaceIndex: indexInTLWorkspaces,
                            willDeletedWorkspace: _corrWorkspace));
                  },
                  icon: Icons.remove,
                  label: "Delete",
                ),
              ],
            ),
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          indexInTLWorkspaces == 0
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.35,
                  children: [
                    SlidableAction(
                      autoClose: true,
                      spacing: 8,
                      backgroundColor: _tlThemeData.panelColor,
                      foregroundColor: _tlThemeData.accentColor,
                      onPressed: (BuildContext context) async {
                        await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AddOrEditWorkspaceDialog(
                                  oldIndexInStringWorkspaces:
                                      indexInTLWorkspaces);
                            });
                      },
                      icon: Icons.edit,
                      label: "Edit",
                    ),
                  ],
                ),
      child: child,
    );
  }
}
