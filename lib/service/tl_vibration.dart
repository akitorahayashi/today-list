import 'tl_pref.dart';
import 'package:flutter/services.dart';

class TLVibrationService {
  static int vibrationStrength = 2;

  static Future<void> initVibrate() async {
    await TLPrefService().getPref.then((pref) {
      TLVibrationService.vibrationStrength =
          pref.getInt("vibrationStrength") ?? 2;
      if (vibrationStrength < 0 || vibrationStrength > 3) {
        vibrationStrength = 2;
      }
    });
  }

  static Future<void> saveVibrationStrength() async {
    await TLPrefService().getPref.then(
      (pref) => pref.setInt(
        "vibrationStrength",
        TLVibrationService.vibrationStrength,
      ),
    );
  }

  static void vibrate() {
    switch (TLVibrationService.vibrationStrength) {
      case 0:
        break;
      case 1:
        HapticFeedback.lightImpact();
        break;
      case 2:
        HapticFeedback.mediumImpact();
        break;
      case 3:
        HapticFeedback.heavyImpact();
        break;
    }
  }
}
