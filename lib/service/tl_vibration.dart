import 'tl_pref.dart';

import 'package:flutter_vibrate/flutter_vibrate.dart';

class TLVibrationService {
  static double vibrationStrength = 2.0;
  static bool canVibrate = false;

  static Future<void> initVibrate() async {
    bool canVibrateOrNot = await Vibrate.canVibrate;
    canVibrate = canVibrateOrNot;
    if (canVibrate) {
      await TLPrefService().getPref.then((pref) {
        TLVibrationService.vibrationStrength =
            pref.getDouble("vibrationStrength") ?? 2.0;
      });
    }
  }

  static Future<void> saveVibrationStrength() async {
    await TLPrefService().getPref.then((pref) => pref.setDouble(
        "vibrationStrength", TLVibrationService.vibrationStrength));
  }

  static void vibrate() {
    if (canVibrate) {
      switch (TLVibrationService.vibrationStrength) {
        case 0:
          break;
        case 1:
          Vibrate.feedback(FeedbackType.light);
        case 2:
          Vibrate.feedback(FeedbackType.medium);
        case 3:
          Vibrate.feedback(FeedbackType.heavy);
        case 4:
          Vibrate.feedback(FeedbackType.success);
      }
    }
  }
}
