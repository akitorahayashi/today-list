import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../model/todo/tl_workspace.dart';
import '../../../../service/tl_vibration.dart';
import '../../../../styles.dart';

class DeleteWorkspaceDialog extends ConsumerWidget with TLBaseDialogMixin {
  final int corrWorkspaceIndex;
  final TLWorkspace willDeletedWorkspace;
  const DeleteWorkspaceDialog(
      {super.key,
      required this.corrWorkspaceIndex,
      required this.willDeletedWorkspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    return Dialog(
      backgroundColor: tlThemeData.alertBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // workspaceの削除
            Text(
              "Workspaceの削除",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
            // workspaceを表示
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, bottom: 15.0, left: 10, right: 10),
              child: Text(
                willDeletedWorkspace.name,
                style: TextStyle(
                    color: tlThemeData.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Text(
              "※Workspaceに含まれるToDoも削除されます",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600,
                  fontSize: 13),
            ),
            // はい、いいえボタン
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                // いいえボタン
                TextButton(
                    style:
                        alertButtonStyle(accentColor: tlThemeData.accentColor),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("戻る")),
                // はいボタン
                TextButton(
                    style:
                        alertButtonStyle(accentColor: tlThemeData.accentColor),
                    onPressed: () async {
                      // デフォルトワークスペースは消せない
                      if (corrWorkspaceIndex == 0) {
                        Navigator.pop(context);
                        const TLSingleOptionDialog(
                                title: "エラー",
                                message: '"デフォルト"のWorkspaceは\n削除できません')
                            .show(context: context);
                      } else {
                        // TLWorkspacesから削除
                        tlAppStateReducer.dispatchWorkspaceAction(
                            TLWorkspaceAction.removeWorkspace(
                                willDeletedWorkspace.id));
                        // currentWorkspaceIndexが削除するWorkspaceよりも大きい場合は1減らす
                        if (corrWorkspaceIndex <
                            tlAppState.currentWorkspaceIndex) {
                          tlAppStateReducer.dispatchWorkspaceAction(
                              TLWorkspaceAction.changeCurrentWorkspaceIndex(
                                  tlAppState.currentWorkspaceIndex - 1));
                        }

                        // このアラートを消してsimpleアラートを表示する
                        Navigator.pop(context);
                        TLVibrationService.vibrate();
                        const TLSingleOptionDialog(title: "削除することに\n成功しました！")
                            .show(context: context);
                      }
                    },
                    child: const Text("削除"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
