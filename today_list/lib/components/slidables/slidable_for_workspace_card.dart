import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../model/workspace/current_tl_workspace_provider.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces_provider.dart';
import '../../components/dialog/common/yes_no_dialog.dart';
import '../../model/design/tl_theme.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForWorkspaceCard extends ConsumerWidget {
  final bool isInDrawerList;
  final bool isCurrentWorkspace;
  final int indexInTLWorkspaces;
  final Widget child;
  const SlidableForWorkspaceCard({
    super.key,
    required this.isInDrawerList,
    required this.isCurrentWorkspace,
    required this.indexInTLWorkspaces,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace _currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    return Slidable(
      // currentWorkspaceの時や
      startActionPane: widget.isCurrentWorkspace ||
              // デフォルトワークスペースの時は削除できないようにする
              (widget.indexInTLWorkspaces == 0)
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
                  onPressed: (BuildContext context) {
                    if (!widget.isInDrawerList) {
                      Navigator.pop(context);
                    }
                    showDialog(
                        context: context,
                        builder: (context) => YesNoDialog(
                            title: title,
                            message: message,
                            yesAction: () async {
                              await deleteWorkspaceAlert(
                                  context: context,
                                  indexInTLWorkspaces:
                                      widget.indexInTLWorkspaces);
                            }));
                    deleteWorkspaceAlert(
                        context: context,
                        indexInTLWorkspaces: widget.indexInTLWorkspaces);
                  },
                  icon: Icons.remove,
                  label: "Delete",
                ),
              ],
            ),
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          widget.indexInTLWorkspaces == 0
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
                        if (!widget.isInDrawerList) {
                          Navigator.pop(context);
                        }
                        await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AddOrEditWorkspaceDialog(
                                  oldIndexInStringWorkspaces:
                                      widget.indexInTLWorkspaces);
                            });
                        setState(() {});
                      },
                      icon: Icons.edit,
                      label: "Edit",
                    ),
                  ],
                ),
      child: widget.child,
    );
  }
}
