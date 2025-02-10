import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:today_list/model/tl_app_state.dart';
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

    // MARK: - Colors
    final backgroundColor = tlThemeData.canTapCardColor;
    final foregroundColor = tlThemeData.accentColor;

    return Slidable(
      // currentWorkspaceの時や
      startActionPane: isCurrentWorkspace ||
              // デフォルトワークスペースの時は削除できないようにする
              corrWorkspacesID == noneID
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.25,
              children: [
                // For deleting workspace
                SlidableAction(
                  autoClose: true,
                  spacing: 8,
                  backgroundColor: backgroundColor,
                  foregroundColor: foregroundColor,
                  onPressed: (BuildContext context) async {
                    await showDialog(
                        context: context,
                        builder: (context) => DeleteWorkspaceDialog(
                            corrWorkspaceID: corrWorkspacesID));
                  },
                  icon: Icons.remove,
                ),
              ],
            ),
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          corrWorkspacesID == noneID
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.25,
                  children: [
                    SlidableAction(
                      autoClose: true,
                      spacing: 8,
                      backgroundColor: backgroundColor,
                      foregroundColor: foregroundColor,
                      onPressed: (BuildContext context) async {
                        AddOrEditWorkspaceDialog(
                                oldWorkspaceId: corrWorkspacesID)
                            .show(context: context);
                      },
                      icon: Icons.edit,
                    ),
                  ],
                ),
      child: child,
    );
  }
}
