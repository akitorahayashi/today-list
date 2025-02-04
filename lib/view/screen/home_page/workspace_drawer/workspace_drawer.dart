import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'change_workspace_card.dart';
import '../../../component/common_ui_part/tl_sliver_appbar.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/todo/tl_workspace.dart';
import 'add_workspace_button.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TLWorkspaceDrawer extends ConsumerWidget {
  final bool isContentMode;
  const TLWorkspaceDrawer({super.key, required this.isContentMode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final int currentTLWorkspaceIndex = tlAppState.currentWorkspaceIndex;
    final TLAppStateReducer tlAppStateReducer =
        ref.read(tlAppStateProvider.notifier);

    return Drawer(
      child: Stack(
        children: [
          // 背景色
          Container(color: tlThemeData.backgroundColor),
          CustomScrollView(
            slivers: [
              TLSliverAppBar(
                pageTitle: "Workspace",
                leadingButtonOnPressed: null,
                leadingIcon: Container(),
                trailingButtonOnPressed: null,
                trailingIcon: null,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  // 現在のworkspace
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 16, 3, 5),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tlThemeData.panelBorderColor),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 5),
                              child: Text(
                                "current workspace",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            ChangeWorkspaceCard(
                              isInDrawerList: false,
                              indexInWorkspaces: currentTLWorkspaceIndex,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // 他のワークスペースのリスト
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 3, 3, 0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: tlThemeData.panelBorderColor),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            // カードの表示
                            child: Column(
                              children: [
                                // 独立して表示してデフォルトワークスペースの並び替え阻止
                                const ChangeWorkspaceCard(
                                  // TODO isInDrawerListの名前を変更する
                                  isInDrawerList: true,
                                  indexInWorkspaces: 0,
                                ),
                                ReorderableColumn(
                                  children: [
                                    for (int i = 1;
                                        i < tlAppState.tlWorkspaces.length;
                                        i++)
                                      ChangeWorkspaceCard(
                                        key: ValueKey(
                                            tlAppState.tlWorkspaces[i].id),
                                        isInDrawerList: true,
                                        indexInWorkspaces: i,
                                      ),
                                  ],
                                  onReorder: (oldIndex, newIndex) {
                                    if (newIndex == oldIndex) return;

                                    final int revisedOldIndex = oldIndex + 1;
                                    final int revisedNewIndex = newIndex + 1;

                                    List<TLWorkspace> copiedWorkspaces =
                                        List.from(tlAppState.tlWorkspaces);

                                    // 移動する要素を取り出し
                                    final TLWorkspace movedWorkspace =
                                        copiedWorkspaces
                                            .removeAt(revisedOldIndex);
                                    copiedWorkspaces.insert(
                                        revisedNewIndex, movedWorkspace);

                                    // currentWorkspaceIndex を必要に応じて更新
                                    if (revisedOldIndex ==
                                        currentTLWorkspaceIndex) {
                                      tlAppStateReducer.dispatchWorkspaceAction(
                                          ChangeCurrentWorkspaceIndex(
                                              revisedNewIndex));
                                    } else if (revisedOldIndex <
                                            currentTLWorkspaceIndex &&
                                        revisedNewIndex >=
                                            currentTLWorkspaceIndex) {
                                      tlAppStateReducer.dispatchWorkspaceAction(
                                          ChangeCurrentWorkspaceIndex(
                                              currentTLWorkspaceIndex - 1));
                                    } else if (revisedOldIndex >
                                            currentTLWorkspaceIndex &&
                                        revisedNewIndex <=
                                            currentTLWorkspaceIndex) {
                                      tlAppStateReducer.dispatchWorkspaceAction(
                                          ChangeCurrentWorkspaceIndex(
                                              currentTLWorkspaceIndex + 1));
                                    }

                                    // workspaceListを保存する
                                    tlAppStateReducer.dispatchWorkspaceAction(
                                        TLWorkspaceAction.updateWorkspaceList(
                                            copiedWorkspaces));
                                  },
                                ),
                                // 新しくworkspaceを追加する,
                                const AddWorkspaceButton(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
