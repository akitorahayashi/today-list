import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:today_list/model/tl_theme.dart';

class SettingData {
  static Future<void> changeIcon(String? iconName) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        if (iconName == tlThemeDataList[0].themeName) {
          print('Icon changed to: $iconName');
          await FlutterDynamicIcon.setAlternateIconName(null);
        } else {
          print('Icon changed to: $iconName');
          await FlutterDynamicIcon.setAlternateIconName(iconName);
        }
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
  }
}
