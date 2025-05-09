import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'package:today_list/view/component/dialog/for_workspace/delete_workspace_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/model/design/tl_theme.dart';

class SelectEditWorkspaceMethodDialog extends ConsumerWidget
    with TLBaseDialogMixin {
  final bool isCurrentWorkspace;
  final TLWorkspace corrWorkspace;
  const SelectEditWorkspaceMethodDialog({
    super.key,
    required this.isCurrentWorkspace,
    required this.corrWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final workspacesAsync = ref.watch(workspacesProvider);

    // notifier
    return TLDialog(
      corrThemeConfig: tlThemeData,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 24, 24, 24),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    "Workspace Name",
                    style: TextStyle(
                      color: Color.fromRGBO(120, 120, 120, 1),
                      fontSize: 13,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    corrWorkspace.name,
                    style: TextStyle(
                      color: tlThemeData.accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // MARK: - Rename
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);

                    Future.microtask(() {
                      if (context.mounted) {
                        AddOrEditWorkspaceDialog(
                          oldWorkspaceId: corrWorkspace.id,
                        ).show(context: context);
                      }
                    });
                  },
                  child: Text(
                    "Rename",
                    style: TextStyle(
                      color: tlThemeData.accentColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // MARK: - Delete
          workspacesAsync.when(
            data: (workspaces) {
              if (!isCurrentWorkspace || workspaces.length > 1) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          Future.microtask(() {
                            if (context.mounted) {
                              DeleteWorkspaceDialog(
                                willDeletedWorkspace: corrWorkspace,
                              ).show(context: context);
                            }
                          });
                        },
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            color: tlThemeData.accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Error loading workspaces'),
          ),
          // 閉じるボタン
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith(
                    (states) => Colors.lightGreen.withValues(alpha: 0.1),
                  ),
                ),
                child: const Text(
                  "close",
                  style: TextStyle(color: Colors.lightGreen),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
