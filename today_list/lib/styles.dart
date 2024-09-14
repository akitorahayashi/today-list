import 'package:flutter/material.dart';
import 'constants/theme.dart';
import 'model/user/setting_data.dart';

// alert
ButtonStyle alertButtonStyle() => ButtonStyle(
      foregroundColor: MaterialStateProperty.all<Color>(
        theme[settingData.selectedTheme]!.accentColor,
      ),
      overlayColor: MaterialStateProperty.all<Color>(
        theme[settingData.selectedTheme]!.accentColor.withOpacity(0.1),
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
          borderSide:
              BorderSide(color: theme[settingData.selectedTheme]!.accentColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: theme[settingData.selectedTheme]!.accentColor),
        ),
        // 完了ボタン
        suffixIcon: suffixIcon);
