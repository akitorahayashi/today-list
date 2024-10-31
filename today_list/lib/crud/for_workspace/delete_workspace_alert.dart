import 'package:flutter/material.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/external/tl_pref.dart';
import '../../model/tl_theme.dart';
import '../../alerts/simple_alert.dart';
import '../../constants/styles.dart';

// Workspaceを消す
Future<void> deleteWorkspaceAlert({
  required BuildContext context,
  required int indexInTLWorkspaces,
}) async {
  final TLThemeData _tlThemeData = TLTheme.of(context);
  final TLWorkspace willDeletedWorkspace =
      TLWorkspace.fromJson(tlworkspaces[indexInTLWorkspaces]);
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
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
                        style: alertButtonStyle(
                            accentColor: _tlThemeData.accentColor),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("戻る")),
                    // はいボタン
                    TextButton(
                        style: alertButtonStyle(
                            accentColor: _tlThemeData.accentColor),
                        onPressed: () {
                          // デフォルトワークスペースは消せない
                          if (indexInTLWorkspaces == 0) {
                            Navigator.pop(context);
                            simpleAlert(
                                context: context,
                                corrThemeData: _tlThemeData,
                                title: "エラー",
                                message: '"デフォルト"のWorkspaceは\n削除できません',
                                buttonText: "OK");
                          } else {
                            // TLWorkspacesから削除
                            TLPref().getPref.then((pref) {
                              if (TLWorkspace.currentWorkspaceIndex >
                                  indexInTLWorkspaces) {
                                TLWorkspace.currentWorkspaceIndex--;
                                pref.setInt("currentWorkspaceIndex",
                                    TLWorkspace.currentWorkspaceIndex);
                              }
                              tlworkspaces.removeAt(indexInTLWorkspaces);
                              // このアラートを消してsimpleアラートを表示する
                              Navigator.pop(context);
                              TLVibration.vibrate();
                              simpleAlert(
                                  context: context,
                                  corrThemeData: _tlThemeData,
                                  title: "削除することに\n成功しました!",
                                  message: null,
                                  buttonText: "OK");
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
      });
}
