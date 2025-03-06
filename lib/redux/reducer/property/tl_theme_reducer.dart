import 'package:flutter/material.dart';
import 'package:today_list/redux/action/tl_theme_action.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_method_channel.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

class TLThemeReducer {
  static TLThemeType reduce(TLThemeType currentTheme, TLThemeAction action) {
    final updatedThemeType = action.map(
      changeTheme: (a) => _changeTheme(currentTheme, a.newThemeType),
      changeAccentColor: (a) =>
          currentTheme, // アクセントカラーの変更はユーザーデータで管理するため、テーマは変更しない
    );
    return updatedThemeType;
  }

  static TLThemeType _changeTheme(
      TLThemeType currentTheme, TLThemeType newTheme) {
    TCWiOSMethodChannelService.updateSelectedTheme(selectedThemeType: newTheme);
    return newTheme;
  }

  static TLThemeType _changeAccentColor(
      TLThemeType currentTheme, String themeName, Color accentColor) {
    // 現在のテーマのテーマ名が一致する場合のみ変更
    if (currentTheme.config.themeName == themeName) {
      // カスタムアクセントカラーを設定した新しいテーマ設定を作成
      final updatedConfig =
          currentTheme.config.copyWithCustomAccentColor(accentColor);

      // 新しいテーマ設定を持つ同じタイプのテーマを返す
      // 注意: これは実際には新しいテーマインスタンスを作成するわけではなく、
      // 既存のテーマを返します。実際のカスタムアクセントカラーの適用は
      // TLThemeProviderなどで行う必要があります。
    }

    // テーマ名が一致しない場合は現在のテーマをそのまま返す
    return currentTheme;
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
