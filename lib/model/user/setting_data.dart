import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:today_list/model/tl_theme.dart';

class SettingData {
  static Future<void> changeIcon({required String themeName}) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(themeName);
        print('Icon changed to: $themeName');
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
  }
}
