import 'package:flutter/material.dart';
import '../model/tl_theme.dart';

// alert
ButtonStyle alertButtonStyle({required BuildContext context}) {
  final TLThemeData _tlThemeData = TLTheme.of(context);
  return ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(
      _tlThemeData.accentColor,
    ),
    overlayColor: WidgetStateProperty.all<Color>(
      _tlThemeData.accentColor.withOpacity(0.1),
    ),
  );
}

// ButtonStyle(

//       foregroundColor: WidgetStateProperty.all<Color>(
//         tlThemeDataList[SettingData.shared.selectedThemeIndex]!.accentColor,
//       ),
//       overlayColor: WidgetStateProperty.all<Color>(
//         tlThemeDataList[SettingData.shared.selectedThemeIndex]!
//             .accentColor
//             .withOpacity(0.1),
//       ),
//     );

// text field
InputDecoration tlInputDecoration({
  required BuildContext context,
  required String labelText,
  required Widget? icon,
  required Widget? suffixIcon,
}) {
  final TLThemeData _tlThemeData = TLTheme.of(context);
  return InputDecoration(
      icon: icon,
      label: Text(labelText),
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.45)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _tlThemeData.accentColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _tlThemeData.accentColor),
      ),
      // 完了ボタン
      suffixIcon: suffixIcon);
}
