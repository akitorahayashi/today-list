import 'package:flutter/material.dart';
import '../../../../styles.dart';
import '../../../../model/user/setting_data.dart';
import '../../../../constants/theme.dart';

Future<void> notifyCurrentWorkspaceIsChanged({
  required BuildContext context,
  required String newWorkspaceName,
}) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: theme[SettingData.shared.selectedTheme]!.alertColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 10),
                  child: Text(
                    "workspaceを",
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    newWorkspaceName,
                    style: TextStyle(
                        color: theme[SettingData.shared.selectedTheme]!
                            .accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Text(
                  "に変更しました!",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    style: alertButtonStyle(),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            ),
          ),
        );
      });
}
