import 'package:flutter/material.dart';
import 'package:today_list/model/workspace/id_to_jsonworkspaceList.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../model/tl_category.dart';
import '../../../../constants/theme.dart';
import '../../../../constants/global_keys.dart';
import '../../../../crud/for_workspace/delete_workspace_alert.dart';
import '../../../../crud/for_workspace/add_or_edit_workspace_alert.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForWorkspaceCard extends StatefulWidget {
  final bool isInDrawerList;
  final bool isCurrentWorkspace;
  final TLCategory workspaceCategoryOfThisCard;
  final int indexInStringWorkspaces;
  final Widget child;
  const SlidableForWorkspaceCard({
    super.key,
    required this.isInDrawerList,
    required this.isCurrentWorkspace,
    required this.workspaceCategoryOfThisCard,
    required this.indexInStringWorkspaces,
    required this.child,
  });

  @override
  State<SlidableForWorkspaceCard> createState() =>
      _SlidableForWorkspaceCardState();
}

class _SlidableForWorkspaceCardState extends State<SlidableForWorkspaceCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      // currentWorkspaceの時や
      startActionPane: widget.isCurrentWorkspace ||
              // デフォルトワークスペースの時は削除できないようにする
              (widget.workspaceCategoryOfThisCard.id == noneId &&
                  widget.indexInStringWorkspaces == 0)
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.35,
              children: [
                SlidableAction(
                  autoClose: true,
                  spacing: 8,
                  backgroundColor: theme[settingData.selectedTheme]!.panelColor,
                  foregroundColor:
                      theme[settingData.selectedTheme]!.accentColor,
                  onPressed: (BuildContext context) {
                    if (!widget.isInDrawerList) {
                      Navigator.pop(context);
                    }
                    deleteWorkspaceAlert(
                        context: context,
                        selectedWorkspaceCategoryId:
                            widget.workspaceCategoryOfThisCard.id,
                        indexInStringWorkspaces:
                            widget.indexInStringWorkspaces);
                  },
                  icon: Icons.remove,
                  label: "Delete",
                ),
              ],
            ),
      endActionPane: // デフォルトワークスペースの時は編集できないようにする
          (widget.workspaceCategoryOfThisCard.id == noneId &&
                  widget.indexInStringWorkspaces == 0)
              ? null
              : ActionPane(
                  motion: const ScrollMotion(),
                  extentRatio: 0.35,
                  children: [
                    SlidableAction(
                      autoClose: true,
                      spacing: 8,
                      backgroundColor:
                          theme[settingData.selectedTheme]!.panelColor,
                      foregroundColor:
                          theme[settingData.selectedTheme]!.accentColor,
                      onPressed: (BuildContext context) async {
                        if (!widget.isInDrawerList) {
                          Navigator.pop(context);
                        }
                        await showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AddOrEditWorkspaceDialog(
                                  oldWorkspaceCategory:
                                      widget.workspaceCategoryOfThisCard,
                                  oldIndexInStringWorkspaces:
                                      widget.indexInStringWorkspaces);
                            });
                        setState(() {});
                        drawerForWorkspaceKey.currentState?.setState(() {});
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
