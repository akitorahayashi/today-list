import 'package:flutter/material.dart';
import '../model/design/tl_theme.dart';

// alert
ButtonStyle alertButtonStyle({required Color accentColor}) {
  return ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(
      accentColor,
    ),
    overlayColor: WidgetStateProperty.all<Color>(
      accentColor.withOpacity(0.1),
    ),
  );
}

// text field
InputDecoration tlInputDecoration({
  required BuildContext context,
  required String labelText,
  required Widget? icon,
  required Widget? suffixIcon,
}) {
  final TLThemeData tlThemeData = TLTheme.of(context);
  return InputDecoration(
      icon: icon,
      label: Text(labelText),
      labelStyle: TextStyle(color: Colors.black.withOpacity(0.45)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: tlThemeData.accentColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: tlThemeData.accentColor),
      ),
      // 完了ボタン
      suffixIcon: suffixIcon);
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
