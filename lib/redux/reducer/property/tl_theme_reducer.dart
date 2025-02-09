import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';

class TLThemeReducer {
  static TLThemeType handle(TLThemeType currentTheme, TLThemeAction action) {
    return action.map(
      changeTheme: (a) {
        final newTheme = a.themeType;
        _saveTheme(newTheme);
        return newTheme;
      },
    );
  }

  // テーマをSharedPreferencesに保存する関数
  static void _saveTheme(TLThemeType themeType) {
    // TLConnectivityService.sendSelectedThemeToAppleWatch(
    //     selectedThemeIndex: corrIndex);
    TLMethodChannelService.updateSelectedTheme(selectedThemeType: themeType);
    TLVibrationService.vibrate();
    TLPrefService().getPref.then((pref) {
      pref.setString('themeType', themeType.name);
    });
  }
}
