import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/action/workspace_action.dart';
import 'package:today_list/flux/dispatcher/workspace_dispatcher.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class DeleteWorkspaceDialog extends ConsumerWidget with TLBaseDialogMixin {
  final TLWorkspace willDeletedWorkspace;

  const DeleteWorkspaceDialog({super.key, required this.willDeletedWorkspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    return TLDialog(
      corrThemeConfig: tlThemeConfig,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Delete This Workspace?",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 0.0,
                left: 10,
                right: 10,
              ),
              child: Text(
                willDeletedWorkspace.name,
                style: TextStyle(
                  color: tlThemeConfig.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Text(
                "ToDos included in the workspace will also be deleted.",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: _buildActionButtons(context, ref, tlThemeConfig),
            ),
          ],
        ),
      ),
    );
  }

  // MARK - Build Action Buttons
  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    TLThemeConfig tlThemeData,
  ) {
    // willDeletedWorkspace を削除
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cancel Button
        TextButton(
          style: alertButtonStyle(accentColor: tlThemeData.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
        // Delete Button
        TextButton(
          style: alertButtonStyle(accentColor: tlThemeData.accentColor),
          onPressed: () async {
            _handleDeleteWorkspace(context, ref);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }

  // MARK - Handle Workspace Deletion
  void _handleDeleteWorkspace(BuildContext context, WidgetRef ref) async {
    // Remove workspace
    await WorkspaceDispatcher.dispatch(
      ref,
      WorkspaceAction.deleteWorkspace(willDeletedWorkspace.id),
    );

    // Close this dialog and show success notification
    if (context.mounted) {
      Navigator.pop(context);
      TLVibrationService.vibrate();
      const TLSingleOptionDialog(
        title: "Successfully deleted!",
      ).show(context: context);
    }
  }
}
