import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:today_list/model/workspace/current_tl_workspace_provider.dart';
import 'change_workspace_card.dart';
import '../../../components/common_ui_part/tl_sliver_appbar.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../model/workspace/tl_workspaces_provider.dart';
import './add_workspace_button.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class TLWorkspaceDrawer extends ConsumerWidget {
  final bool isContentMode;
  const TLWorkspaceDrawer({Key? key, required this.isContentMode})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final List<TLWorkspace> _tlWorkspaces = ref.watch(tlWorkspacesProvider);
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier _currentWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final int _currentTLWorkspaceIndex =
        _currentWorkspaceNotifier.currentTLWorkspaceIndex;

    return Drawer(
      child: Stack(
        children: [
          // 背景色
          Container(color: _tlThemeData.backgroundColor),
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
                          color: _tlThemeData.panelBorderColor),
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
                              indexInWorkspaces: _currentTLWorkspaceIndex,
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
                          color: _tlThemeData.panelBorderColor),
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
                                ChangeWorkspaceCard(
                                  // TODO isInDrawerListの名前を変更する
                                  isInDrawerList: false,
                                  indexInWorkspaces: 0,
                                ),
                                ReorderableColumn(
                                  children: [
                                    for (int i = 1;
                                        i < _tlWorkspaces.length;
                                        i++)
                                      ChangeWorkspaceCard(
                                        key: ValueKey(_tlWorkspaces[i].id),
                                        isInDrawerList: true,
                                        indexInWorkspaces: i,
                                      ),
                                  ],
                                  onReorder: (oldIndex, newIndex) {
                                    final int revisedOldIndex = oldIndex += 1;
                                    final int revisedNewIndex = newIndex += 1;

                                    final reorderedWorkspace =
                                        _tlWorkspaces.removeAt(revisedOldIndex);
                                    _tlWorkspaces.insert(
                                        revisedNewIndex, reorderedWorkspace);

                                    // currentWorkspaceIndex を必要に応じて更新
                                    if (revisedOldIndex ==
                                        _currentTLWorkspaceIndex) {
                                      // 移動したWorkspaceが現在のWorkspaceだった場合
                                      _currentWorkspaceNotifier
                                          .changeCurrentWorkspaceIndex(
                                              newCurrentWorkspaceIndex:
                                                  revisedNewIndex);
                                    } else if (revisedOldIndex <
                                            _currentWorkspaceNotifier
                                                .currentTLWorkspaceIndex &&
                                        revisedNewIndex >=
                                            _currentWorkspaceNotifier
                                                .currentTLWorkspaceIndex) {
                                      // currentWorkspaceIndexが移動範囲内にある場合（下方向に移動）
                                      _currentWorkspaceNotifier
                                          .changeCurrentWorkspaceIndex(
                                              newCurrentWorkspaceIndex:
                                                  _currentWorkspaceNotifier
                                                          .currentTLWorkspaceIndex -
                                                      1);
                                    } else if (revisedOldIndex >
                                            _currentWorkspaceNotifier
                                                .currentTLWorkspaceIndex &&
                                        revisedNewIndex <=
                                            _currentWorkspaceNotifier
                                                .currentTLWorkspaceIndex) {
                                      // currentWorkspaceIndexが移動範囲内にある場合（上方向に移動）
                                      _currentWorkspaceNotifier
                                          .changeCurrentWorkspaceIndex(
                                              newCurrentWorkspaceIndex:
                                                  _currentWorkspaceNotifier
                                                          .currentTLWorkspaceIndex +
                                                      1);
                                    }

                                    // toDosを保存する
                                    _tlWorkspacesNotifier.updateTLWorkspaceList(
                                        updatedTLWorkspaceList: _tlWorkspaces);
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
