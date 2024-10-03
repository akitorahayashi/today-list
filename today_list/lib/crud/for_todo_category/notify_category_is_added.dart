import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../model/user/setting_data.dart';
import '../../styles.dart';

void notifyCategoryIsAdded(
    {required BuildContext context, required String addedCategoryName}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: theme[settingData.selectedTheme]!.alertColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 12),
                  child: Text(
                    addedCategoryName,
                    style: TextStyle(
                        color: theme[settingData.selectedTheme]!.accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Text(
                  "を追加しました!",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: alertButtonStyle(),
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: theme[settingData.selectedTheme]!.accentColor),
                    ))
              ],
            ),
          ),
        );
      });
}
