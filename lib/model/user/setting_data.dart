import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

class SettingData {
  static Future<void> changeIcon(String? iconName) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(iconName);
        print('Icon changed to: $iconName');
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
  }
}
