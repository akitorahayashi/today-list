import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TLVibration {
  static double vibrationStrength = 2.0;
  static bool canVibrate = false;

  static Future<void> initVibrate() async {
    bool canVibrateOrNot = await Vibrate.canVibrate;
    canVibrate = canVibrateOrNot;
    if (canVibrate) {
      await SharedPreferences.getInstance().then((pref) {
        TLVibration.vibrationStrength =
            pref.getDouble("vibrationStrength") ?? 2.0;
      });
    }
  }

  static Future<void> saveVibrationStrength() async {
    await SharedPreferences.getInstance().then((pref) =>
        pref.setDouble("vibrationStrength", TLVibration.vibrationStrength));
  }

  static void vibrate() {
    if (canVibrate) {
      switch (TLVibration.vibrationStrength) {
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
