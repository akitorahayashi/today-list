import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/tl_workspace.dart';
import '../../../model/external/tl_vibration.dart';
import '../../../style/styles.dart';

class DeleteWorkspaceDialog extends ConsumerWidget {
  final int corrWorkspaceIndex;
  final TLWorkspace willDeletedWorkspace;
  const DeleteWorkspaceDialog(
      {super.key,
      required this.corrWorkspaceIndex,
      required this.willDeletedWorkspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier currentTLWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
    return Dialog(
      backgroundColor: tlThemeData.alertColor,
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
                        TLSingleOptionDialog.show(
                            context: context,
                            title: "エラー",
                            message: '"デフォルト"のWorkspaceは\n削除できません');
                      } else {
                        // TLWorkspacesから削除
                        tlWorkspacesNotifier.removeWorkspace(
                            corrWorkspaceId: willDeletedWorkspace.id);
                        // currentWorkspaceIndexが削除するWorkspaceよりも大きい場合は1減らす
                        if (corrWorkspaceIndex <
                            currentTLWorkspaceNotifier.currentWorkspaceIndex) {
                          currentTLWorkspaceNotifier
                              .changeCurrentWorkspaceIndex(
                                  newCurrentWorkspaceIndex:
                                      currentTLWorkspaceNotifier
                                              .currentWorkspaceIndex -
                                          1);
                        }

                        // このアラートを消してsimpleアラートを表示する
                        Navigator.pop(context);
                        TLVibration.vibrate();
                        TLSingleOptionDialog.show(
                            context: context, title: "削除することに\n成功しました！");
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
