import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'package:today_list/view/component/dialog/for_workspace/delete_workspace_dialog.dart';

class SlidableForWorkspaceCard extends ConsumerWidget {
  final bool isCurrentWorkspace;
  final String corrWorkspacesID;
  final Widget child;
  const SlidableForWorkspaceCard({
    super.key,
    required this.isCurrentWorkspace,
    required this.corrWorkspacesID,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // final TLWorkspace corrWorkspace = tlWorkspacesRef[corrWorkspacesID];
    return Slidable(
      // currentWorkspaceの時や
      startActionPane: isCurrentWorkspace ||
              // デフォルトワークスペースの時は削除できないようにする
              corrWorkspacesID == 0
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.35,
              children: [
                // For deleting workspace
                SlidableAction(
                  autoClose: true,
                  spacing: 8,
                  backgroundColor: tlThemeData.canTapCardColor,
                  foregroundColor: tlThemeData.accentColor,
                  onPressed: (BuildContext context) async {
                    await showDialog(
                        context: context,
                        builder: (context) => DeleteWorkspaceDialog(
                            corrWorkspaceID: corrWorkspacesID));
                  },
                  icon: Icons.remove,
                  label: "Delete",
                ),
              ],
            ),
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          corrWorkspacesID == 0
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.35,
                  children: [
                    SlidableAction(
                      autoClose: true,
                      spacing: 8,
                      backgroundColor: tlThemeData.canTapCardColor,
                      foregroundColor: tlThemeData.accentColor,
                      onPressed: (BuildContext context) async {
                        AddOrEditWorkspaceDialog(
                                oldWorkspaceId: corrWorkspacesID)
                            .show(context: context);
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
