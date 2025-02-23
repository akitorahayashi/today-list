import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';

class TLThemeReducer {
  static TLThemeType handle(TLThemeType currentTheme, TLThemeAction action) {
    final updatedThemeType = action.map(
      changeTheme: (a) => _changeTheme(currentTheme, a.newThemeType),
    );
    return updatedThemeType;
  }

  static TLThemeType _changeTheme(
      TLThemeType currentTheme, TLThemeType newTheme) {
    return newTheme;
  }

  // テーマをSharedPreferencesに保存する関数
  // static Future<void> _saveTheme(TLThemeType themeType) async {
  //   // TLConnectivityService.sendSelectedThemeToAppleWatch(
  //   //     selectedThemeIndex: corrIndex);
  //   TLMethodChannelService.updateSelectedTheme(selectedThemeType: themeType);
  //   TLVibrationService.vibrate();
  //   await TLPrefService().getPref.then((pref) {
  //     pref.setString('themeType', themeType.name);
  //   });
  // }
}
