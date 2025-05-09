import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/util/device_util.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/flux/action/workspace_action.dart';
import 'package:today_list/flux/dispatcher/workspace_dispatcher.dart';
import 'change_workspace_card.dart';

class TLWorkspaceDrawer extends ConsumerWidget {
  const TLWorkspaceDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final workspacesAsync = ref.watch(workspacesProvider);

    return Drawer(
      child: Stack(
        children: [
          Container(color: tlThemeConfig.backgroundColor),
          Column(
            children: [
              if (!DeviceUtil.isTablet(context))
                TLAppBar(
                  context: context,
                  pageTitle: "Workspace",
                  leadingButtonOnPressed: null,
                  leadingIconData: null,
                  trailingButtonOnPressed: null,
                  trailingIconData: null,
                ),
              Expanded(
                child: workspacesAsync.when(
                  data:
                      (workspaces) => ListView(
                        padding: const EdgeInsets.only(bottom: 200),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 12.0,
                              left: 3.0,
                              right: 3.0,
                            ),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: tlThemeConfig.tlDoubleCardBorderColor,
                              ),
                              child: Card(
                                color: tlThemeConfig.whiteBasedColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 5.0,
                                    bottom: 3.0,
                                  ),
                                  child: SingleChildScrollView(
                                    // スクロール可能にする
                                    child: Column(
                                      children: [
                                        ReorderableColumn(
                                          children: [
                                            for (var workspace in workspaces)
                                              WorkspaceCard(
                                                key: ValueKey(workspace.id),
                                                corrWorkspace: workspace,
                                              ),
                                          ],
                                          onReorder: (oldIndex, newIndex) {
                                            WorkspaceDispatcher.dispatch(
                                              ref,
                                              WorkspaceAction.reorderWorkspace(
                                                oldIndex: oldIndex,
                                                newIndex: newIndex,
                                              ),
                                            );
                                          },
                                        ),
                                        const _AddWorkspaceButton(),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (error, stackTrace) =>
                          Center(child: Text('エラーが発生しました: $error')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AddWorkspaceButton extends StatelessWidget {
  const _AddWorkspaceButton();

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: GestureDetector(
          onTap:
              () => const AddOrEditWorkspaceDialog(
                oldWorkspaceId: null,
              ).show(context: context),
          child: Icon(Icons.add, color: tlThemeConfig.accentColor),
        ),
      ),
    );
  }
}
