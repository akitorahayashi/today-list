import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'model/user/setting_data.dart';

// alert
ButtonStyle alertButtonStyle() => ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        tlThemeDataList[SettingData.shared.selectedThemeIndex]!.accentColor,
      ),
      overlayColor: MaterialStateProperty.all<Color>(
        tlThemeDataList[SettingData.shared.selectedThemeIndex]!
            .accentColor
            .withOpacity(0.1),
      ),
    );

// text field
InputDecoration tlInputDecoration({
  required String labelText,
  required Widget? icon,
  required Widget? suffixIcon,
}) =>
    InputDecoration(
        icon: icon,
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(0.45)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: tlThemeDataList[SettingData.shared.selectedThemeIndex]!
                  .accentColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: tlThemeDataList[SettingData.shared.selectedThemeIndex]!
                  .accentColor),
        ),
        // 完了ボタン
        suffixIcon: suffixIcon);
