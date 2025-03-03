import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'model/design/tl_theme.dart';

// alert
ButtonStyle alertButtonStyle({required Color accentColor}) {
  return ButtonStyle(
    foregroundColor: WidgetStateProperty.all<Color>(
      accentColor,
    ),
    overlayColor: WidgetStateProperty.all<Color>(
      accentColor.withValues(alpha: 0.1),
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
  final TLThemeConfig tlThemeConfig = TLTheme.of(context);
  return InputDecoration(
      icon: icon,
      label: Text(labelText),
      labelStyle: TextStyle(color: Colors.black.withValues(alpha: 0.45)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: tlThemeConfig.accentColor),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: tlThemeConfig.accentColor),
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
//             .withValues(alpha: 0.1),
//       ),
//     );
