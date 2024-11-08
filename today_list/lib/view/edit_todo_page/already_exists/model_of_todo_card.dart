import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/todo_card/icon_for_checkbox.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/tl_workspace.dart';
import '../../../components/slidables/slidable_for_todo_card.dart';

import 'package:reorderables/reorderables.dart';

class ModelOfToDoCard extends ConsumerWidget {
  // todoのデータ
  final TLToDo corrTLToDo;
  final bool ifInToday;
  final String bigCategoryID;
  final String? smallCategoryID;
  final int indexOfThisToDoInToDoArrray;
  // 編集系の変数
  final int? indexOfEditingToDo;
  final Function tapToEditAction;
  const ModelOfToDoCard({
    super.key,
    // todoのデータ
    required this.corrTLToDo,
    required this.ifInToday,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.indexOfThisToDoInToDoArrray,
    // 編集系の変数
    required this.indexOfEditingToDo,
    required this.tapToEditAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentWorkspace = ref.watch(currentTLWorkspaceProvider);
    // notifier
    final CurrentTLWorkspaceNotifier currentWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    return Card(
      color: tlThemeData.panelColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SlidableForToDoCard(
          isForModelCard: true,
          corrTLToDo: corrTLToDo,
          ifInToday: ifInToday,
          // category
          bigCategoryID: bigCategoryID,
          smallCategoryID: smallCategoryID,
          indexOfThisToDoInToDos: indexOfThisToDoInToDoArrray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 選択した日があれば表示
              // if (toDoData.scheduledDate != null)
              //   Padding(
              //     padding: const EdgeInsets.only(left: 16.0, top: 10.0),
              //     child: Align(
              //         alignment: Alignment.bottomLeft,
              //         child: Text(
              //           toDoData.scheduledDate!,
              //           style: TextStyle(
              //               color: theme[settingData.selectedTheme]!
              //                   .accentColor
              //                   .withOpacity(0.9),
              //               fontWeight: FontWeight.w600,
              //               fontSize: 12),
              //         )),
              //   ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    16,
                    // toDoData.scheduledDate != null ? 10 :
                    18,
                    16,
                    corrTLToDo.steps.isNotEmpty ? 15 : 18),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // 左側のチェックボックス
                    Padding(
                        padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                        // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Transform.scale(
                          scale: 1.2,
                          child: TLCheckBox(isChecked: corrTLToDo.isChecked),
                        )),
                    // toDoのタイトル
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          corrTLToDo.title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(
                                  corrTLToDo.isChecked ? 0.3 : 0.6)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // steps
              if (corrTLToDo.steps.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ReorderableColumn(
                    children: corrTLToDo.steps.map((stepData) {
                      return Padding(
                        key: Key(UniqueKey().toString()),
                        padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                            child: Row(
                              children: [
                                // 左側のチェックボックス
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 0, 16, 0),
                                  child: Transform.scale(
                                    scale: 1.2,
                                    child: TLCheckBox(
                                        isChecked: stepData.isChecked),
                                  ),
                                ),
                                // stepのタイトル
                                Expanded(
                                  child: Text(stepData.title,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black.withOpacity(
                                              stepData.isChecked ? 0.3 : 0.6))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onReorder: (oldIndex, newIndex) {
                      final reOrderedStep = corrTLToDo.steps.removeAt(oldIndex);
                      if (oldIndex < newIndex) newIndex -= 1;
                      corrTLToDo.steps.insert(newIndex, reOrderedStep);
                      // currentWorkspaceを更新
                      tlWorkspacesNotifier.updateSpecificTLWorkspace(
                        specificWorkspaceIndex:
                            currentWorkspaceNotifier.currentTLWorkspaceIndex,
                        updatedWorkspace: currentWorkspace,
                      );
                    },
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
