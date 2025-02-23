import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import '../common/tl_single_option_dialog.dart';

class DeleteWorkspaceDialog extends ConsumerWidget with TLBaseDialogMixin {
  final TLWorkspace willDeletedWorkspace;

  const DeleteWorkspaceDialog({
    super.key,
    required this.willDeletedWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    return Dialog(
      backgroundColor: tlThemeData.alertBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTitle(),
            _buildWorkspaceNameDisplay(tlThemeData),
            _buildWarningText(),
            _buildActionButtons(
                context, ref, tlAppState, tlAppStateReducer, tlThemeData),
          ],
        ),
      ),
    );
  }

  // MARK - Build Dialog Title
  Widget _buildDialogTitle() {
    return const Text(
      "Workspaceの削除",
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }

  // MARK - Build Workspace Name Display
  Widget _buildWorkspaceNameDisplay(TLThemeConfig tlThemeData) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 15.0, left: 10, right: 10),
      child: Text(
        willDeletedWorkspace.name,
        style: TextStyle(
          color: tlThemeData.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // MARK - Build Warning Text
  Widget _buildWarningText() {
    return const Text(
      "※Workspaceに含まれるToDoも削除されます",
      style: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
    );
  }

  // MARK - Build Action Buttons
  Widget _buildActionButtons(BuildContext context, WidgetRef ref,
      var tlAppState, var tlAppStateReducer, TLThemeConfig tlThemeData) {
    // willDeletedWorkspace を削除
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Cancel Button
        TextButton(
          style: alertButtonStyle(accentColor: tlThemeData.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("戻る"),
        ),
        // Delete Button
        TextButton(
          style: alertButtonStyle(accentColor: tlThemeData.accentColor),
          onPressed: () async {
            _handleDeleteWorkspace(context, ref, tlAppStateReducer);
          },
          child: const Text("削除"),
        ),
      ],
    );
  }

  // MARK - Handle Workspace Deletion
  void _handleDeleteWorkspace(BuildContext context, WidgetRef ref,
      TLAppStateReducer tlAppStateReducer) {
    if (willDeletedWorkspace.id == "defaultID") {
      // Prevent deletion of default workspace
      Navigator.pop(context);
      const TLSingleOptionDialog(
        title: "エラー",
        message: '"デフォルト"のWorkspaceは\n削除できません',
      ).show(context: context);
    } else {
      // Remove workspace
      tlAppStateReducer.dispatchWorkspaceAction(
          TLWorkspaceAction.deleteWorkspace(willDeletedWorkspace));

      // Close this dialog and show success notification
      Navigator.pop(context);
      TLVibrationService.vibrate();
      const TLSingleOptionDialog(title: "削除することに\n成功しました！")
          .show(context: context);
    }
  }
}
