import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'change_workspace_card.dart';

class TLWorkspaceDrawer extends ConsumerWidget {
  const TLWorkspaceDrawer({super.key});

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    final workspaces = ref.watch(
      tlAppStateProvider.select((state) => state.tlWorkspaces),
    );
    return Drawer(
      child: Stack(
        children: [
          Container(color: tlThemeConfig.backgroundColor),
          Column(
            children: [
              TLAppBar(
                context: context,
                pageTitle: "Workspace",
                leadingButtonOnPressed: null,
                leadingIcon: null,
                trailingButtonOnPressed: null,
                trailingIcon: null,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12.0, left: 3.0, right: 3.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: tlThemeConfig.tlDoubleCardBorderColor,
                  ),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 3.0),
                      child: Column(
                        children: [
                          // // デフォルトワークスペース
                          // ChangeWorkspaceCard(
                          //     isDefaultWorkspace: true,
                          //     corrWorkspace: workspaces.first),
                          // デフォルト以外のワークスペース
                          SingleChildScrollView(
                            child: ReorderableColumn(
                              children: [
                                for (var workspace
                                    in workspaces) // 最初のワークスペースは固定
                                  ChangeWorkspaceCard(
                                    key: ValueKey(workspace.id),
                                    isDefaultWorkspace: false,
                                    corrWorkspace: workspace,
                                  ),
                              ],
                              onReorder: (oldIndex, newIndex) {
                                _handleReorder(ref, oldIndex, newIndex);
                              },
                            ),
                          ),
                          const _AddWorkspaceButton(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // MARK: - Handle Reordering Logic
  void _handleReorder(WidgetRef ref, int oldIndex, int newIndex) {
    if (newIndex == oldIndex) return;

    final revisedOldIndex = oldIndex;
    final revisedNewIndex = newIndex;

    final workspaces = ref.read(tlAppStateProvider).tlWorkspaces;

    List<TLWorkspace> copiedWorkspaces = List.from(workspaces);
    final TLWorkspace movedWorkspace =
        copiedWorkspaces.removeAt(revisedOldIndex);
    copiedWorkspaces.insert(revisedNewIndex, movedWorkspace);

    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
        TLWorkspaceAction.updateWorkspaceList(copiedWorkspaces));
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
          onTap: () => const AddOrEditWorkspaceDialog(oldWorkspaceId: null)
              .show(context: context),
          child: Icon(
            Icons.add,
            color: tlThemeConfig.accentColor,
          ),
        ),
      ),
    );
  }
}
