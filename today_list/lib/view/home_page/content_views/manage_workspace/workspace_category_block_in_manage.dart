import 'package:today_list/constants/global_keys.dart';

import '../../../../alerts/common/simple_alert.dart';
import '../../workspace_drawer/change_workspace_card/change_workspace_card.dart';
import '../../../../model/tl_category.dart';
import '../../../../model/workspace/workspace.dart';
import '../../../../model/workspace/id_to_jsonworkspaceList.dart';
import '../../../../crud/for_todo_category/rename_category_dialog.dart';
import '../../../../crud/for_todo_category/delete_category_dialog.dart';
import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class WorkspaceCategoryBlockInManage extends StatefulWidget {
  final int indexOfWorkspaceCategory;
  const WorkspaceCategoryBlockInManage(
      {super.key, required this.indexOfWorkspaceCategory});

  @override
  State<WorkspaceCategoryBlockInManage> createState() =>
      _WorkspaceCategoryBlockInManageState();
}

class _WorkspaceCategoryBlockInManageState
    extends State<WorkspaceCategoryBlockInManage> {
  TLCategory get workspaceCategory =>
      workspaceCategories[widget.indexOfWorkspaceCategory];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: widget.indexOfWorkspaceCategory != 0 ? null : () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.5),
          child: Column(
            children: [
              // header
              if (widget.indexOfWorkspaceCategory != 0)
                Padding(
                  padding: EdgeInsets.only(
                      top: 12.0,
                      bottom: workspaces[workspaceCategory.id]!.isNotEmpty
                          ? 5.0
                          : 12),
                  child: Row(
                    children: [
                      // workspace カテゴリー削除ボタン
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 0),
                        child: GestureDetector(
                          onTap: () async {
                            if (currentWorkspaceCategoryId !=
                                workspaceCategories[
                                        widget.indexOfWorkspaceCategory]
                                    .id) {
                              await confirmToDeleteThisCategory(
                                  context: context,
                                  indexOfWorkspaceCategory:
                                      widget.indexOfWorkspaceCategory,
                                  indexOfBigCategory: 0,
                                  indexOfSmallCategory: null);
                              manageWorkspacePageKey.currentState
                                  // ignore: invalid_use_of_protected_member
                                  ?.setState(() {});
                            } else {
                              await simpleAlert(
                                  context: context,
                                  title: "エラー",
                                  message: "このカテゴリーを削除するためには現在の作業場を変更する必要があります",
                                  buttonText: "OK");
                            }
                          },
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black45,
                            size: 25,
                          ),
                        ),
                      ),
                      // workspace category name
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            workspaceCategory.title,
                            style: const TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      // workspace カテゴリー編集ボタン
                      Padding(
                        padding: const EdgeInsets.only(right: 15.0, left: 0),
                        child: GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => renameCategoryDialog(
                                context: context,
                                indexOfWorkspaceCategory:
                                    widget.indexOfWorkspaceCategory,
                                indexOfBigCategory: 0,
                                indexOfSmallCategory: null,
                              ),
                            );
                            manageWorkspacePageKey.currentState
                                // ignore: invalid_use_of_protected_member
                                ?.setState(() {});
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black45,
                            size: 23,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ReorderableColumn(
                  children: [
                    // body
                    for (int indexInStringWorkspaces = 0;
                        indexInStringWorkspaces <
                            workspaces[workspaceCategory.id]!.length;
                        indexInStringWorkspaces++)
                      GestureDetector(
                        key: Key(UniqueKey().toString()),
                        // デフォルトワークスペースの時は並び替えできないようにする
                        onLongPress: widget.indexOfWorkspaceCategory == 0 &&
                                indexInStringWorkspaces == 0
                            ? () {}
                            : null,
                        child: ChangeWorkspaceCard(
                            isInDrawerList: true,
                            workspaceName: workspaces[workspaceCategory.id]![
                                indexInStringWorkspaces]["name"]!,
                            indexOfWorkspaceCategory:
                                widget.indexOfWorkspaceCategory,
                            indexInStringWorkspaces: indexInStringWorkspaces),
                      )
                  ],
                  onReorder: (oldIndex, newIndex) {
                    // デフォルトワークスペースの並び替え阻止
                    // if (widget.indexOfWorkspaceCategory != 0 &&
                    //     (!(oldIndex == 0 || newIndex == 0))) {
                    final List<dynamic> stringWorkspaceList =
                        workspaces[workspaceCategory.id]!;
                    final reorderedWorkspace =
                        stringWorkspaceList.removeAt(oldIndex);
                    stringWorkspaceList.insert(newIndex, reorderedWorkspace);
                    // currentWorkspaceの修正
                    if (workspaceCategory.id == currentWorkspaceCategoryId) {
                      if (oldIndex == currentWorkspaceIndex) {
                        // current workspaceをつかんで移動した
                        currentWorkspace.changeCurrentWorkspace(
                            selectedWorkspaceCategoryId: workspaceCategory.id,
                            newWorkspaceIndex: newIndex);
                      } else if (oldIndex < currentWorkspaceIndex &&
                          currentWorkspaceIndex <= newIndex) {
                        // current workspaceを上から跨いだ
                        currentWorkspace.changeCurrentWorkspace(
                            selectedWorkspaceCategoryId:
                                currentWorkspaceCategoryId,
                            newWorkspaceIndex: currentWorkspaceIndex -= 1);
                      } else if (newIndex <= currentWorkspaceIndex &&
                          currentWorkspaceIndex < oldIndex) {
                        // current workspaceを下から跨いだ
                        currentWorkspace.changeCurrentWorkspace(
                            selectedWorkspaceCategoryId:
                                currentWorkspaceCategoryId,
                            newWorkspaceIndex: currentWorkspaceIndex + 1);
                      }
                    }
                    Workspace.saveStringWorkspaces();
                    setState(() {});
                    manageWorkspacePageKey.currentState?.setState(() {});
                    // }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
