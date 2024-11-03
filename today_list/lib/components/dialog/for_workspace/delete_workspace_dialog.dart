import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/styles/styles.dart';
import '../../styles/styles.dart';
import '../common/single_option_dialog.dart';
import '../../model/design/tl_theme.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/external/tl_pref.dart';
import '../../model/external/tl_vibration.dart';

class DeleteWorkspaceDialog extends ConsumerWidget {
  final int coorrWorkspaceIndex;
  final TLWorkspace willDeletedWorkspace;
  const DeleteWorkspaceDialog(
      {super.key,
      required this.coorrWorkspaceIndex,
      required this.willDeletedWorkspace});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Dialog(
      backgroundColor: _tlThemeData.alertColor,
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
                    color: _tlThemeData.accentColor,
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
                        alertButtonStyle(accentColor: _tlThemeData.accentColor),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("戻る")),
                // はいボタン
                TextButton(
                    style:
                        alertButtonStyle(accentColor: _tlThemeData.accentColor),
                    onPressed: () {
                      // デフォルトワークスペースは消せない
                      if (coorrWorkspaceIndex == 0) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => SingleOptionDialog(
                                  title: "エラー",
                                  message: '"デフォルト"のWorkspaceは\n削除できません',
                                ));
                      } else {
                        // TLWorkspacesから削除
                        TLPref().getPref.then((pref) {
                          if (TLWorkspace.currentWorkspaceIndex >
                              indexInTLWorkspaces) {
                            TLWorkspace.currentWorkspaceIndex--;
                            pref.setInt("currentWorkspaceIndex",
                                TLWorkspace.currentWorkspaceIndex);
                          }
                          _initialTLWorkspaces.removeAt(indexInTLWorkspaces);
                          // このアラートを消してsimpleアラートを表示する
                          Navigator.pop(context);
                          TLVibration.vibrate();
                          showDialog(
                              context: context,
                              builder: (context) => SingleOptionDialog(
                                    title: "削除することに\n成功しました！",
                                    message: null,
                                  ));
                          // セーブする
                          TLWorkspace.saveSelectedWorkspace(
                              selectedWorkspaceIndex:
                                  TLWorkspace.currentWorkspaceIndex);
                        });
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
