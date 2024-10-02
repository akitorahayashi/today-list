import 'change_workspace_card/change_workspace_card.dart';
import '../../../constants/global_keys.dart';
import '../../../model/tl_category.dart';
import '../../../model/workspace/workspace.dart';
import '../../../model/workspace/id_to_jsonworkspaceList.dart';
import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class WorkspaceCategoryBlockInDrawer extends StatefulWidget {
  final int indexOfWorkspaceCategoryOfThisBlock;
  // final Category workspaceCategory;
  const WorkspaceCategoryBlockInDrawer({
    super.key,
    required this.indexOfWorkspaceCategoryOfThisBlock,
  });

  @override
  State<WorkspaceCategoryBlockInDrawer> createState() =>
      _WorkspaceCategoryBlockInDrawerState();
}

class _WorkspaceCategoryBlockInDrawerState
    extends State<WorkspaceCategoryBlockInDrawer> {
  TLCategory get workspaceCategoryOfThisBlock =>
      workspaceCategories[widget.indexOfWorkspaceCategoryOfThisBlock];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // header
        if (workspaceCategoryOfThisBlock.id != noneId)
          Padding(
            padding: workspaces[workspaceCategoryOfThisBlock.id]!.isNotEmpty
                ? const EdgeInsets.only(top: 10.0, bottom: 0.0)
                : const EdgeInsets.only(top: 10.0, bottom: 20.0),
            child: Text(workspaceCategoryOfThisBlock.title,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                    fontSize: 14,
                    fontWeight: FontWeight.w700)),
          ),
        ReorderableColumn(
          children: [
            for (int indexInStringWorkspace = 0;
                indexInStringWorkspace <
                    workspaces[workspaceCategoryOfThisBlock.id]!.length;
                indexInStringWorkspace++)
              GestureDetector(
                key: Key(UniqueKey().toString()),
                // デフォルトワークスペースの並び替え阻止
                onLongPress: workspaceCategoryOfThisBlock.id == noneId &&
                        indexInStringWorkspace == 0
                    ? () {}
                    : null,
                child: ChangeWorkspaceCard(
                  isInDrawerList: true,
                  workspaceName: workspaces[workspaceCategoryOfThisBlock.id]![
                      indexInStringWorkspace]["name"]!,
                  indexOfWorkspaceCategory:
                      widget.indexOfWorkspaceCategoryOfThisBlock,
                  indexInStringWorkspaces: indexInStringWorkspace,
                ),
              ),
          ],
          onReorder: (oldIndex, newIndex) {
            // デフォルトワークスペースは並び替え不可
            if (!(widget.indexOfWorkspaceCategoryOfThisBlock == 0 &&
                (oldIndex == 0 || newIndex == 0))) {
              final List<dynamic> stringWorkspaceList =
                  workspaces[workspaceCategoryOfThisBlock.id]!;
              final reorderedWorkspace = stringWorkspaceList.removeAt(oldIndex);
              stringWorkspaceList.insert(newIndex, reorderedWorkspace);
              // currentWorkspaceの修正
              if (workspaceCategoryOfThisBlock.id ==
                  currentWorkspaceCategoryId) {
                if (oldIndex == currentWorkspaceIndex) {
                  // current workspaceをつかんで移動した
                  currentWorkspace.changeCurrentWorkspace(
                      selectedWorkspaceCategoryId:
                          workspaceCategoryOfThisBlock.id,
                      newWorkspaceIndex: newIndex);
                } else if (oldIndex < currentWorkspaceIndex &&
                    currentWorkspaceIndex <= newIndex) {
                  // current workspaceを上から跨いだ
                  currentWorkspace.changeCurrentWorkspace(
                      selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                      newWorkspaceIndex: currentWorkspaceIndex -= 1);
                } else if (newIndex <= currentWorkspaceIndex &&
                    currentWorkspaceIndex < oldIndex) {
                  // current workspaceを下から跨いだ
                  currentWorkspace.changeCurrentWorkspace(
                      selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                      newWorkspaceIndex: currentWorkspaceIndex + 1);
                }
              }
              setState(() {});
              manageWorkspacePageKey.currentState?.setState(() {});
              Workspace.saveStringWorkspaces();
            }
          },
        ),
      ],
    );
  }
}
