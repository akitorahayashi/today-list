import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/resource/tl_theme_type.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/service/tl_method_channel.dart';

// テーマタイプのプロバイダー
final themeProvider = AsyncNotifierProvider<ThemeNotifier, TLThemeType>(
  ThemeNotifier.new,
);

// テーマ設定を管理するNotifier
class ThemeNotifier extends AsyncNotifier<TLThemeType> {
  static const _prefKey = 'themeType';

  @override
  Future<TLThemeType> build() async {
    return _loadThemeType();
  }

  Future<TLThemeType> _loadThemeType() async {
    final pref = await TLPrefService().getPref;
    final themeName = pref.getString(_prefKey);

    if (themeName != null) {
      try {
        return TLThemeType.values.firstWhere((t) => t.name == themeName);
      } catch (_) {
        // デフォルトのテーマを返す
        return TLThemeType.notebook;
      }
    }

    // デフォルトのテーマを返す
    return TLThemeType.notebook;
  }

  Future<void> _saveThemeType(TLThemeType themeType) async {
    final pref = await TLPrefService().getPref;
    await pref.setString(_prefKey, themeType.name);
  }

  // テーマタイプを変更
  Future<void> changeTheme(TLThemeType newThemeType) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<TLThemeType>.loading().copyWithPrevious(state);

    try {
      // iOSウィジェットの更新
      TCWiOSMethodChannelService.updateSelectedTheme(
        selectedThemeType: newThemeType,
      );

      await _saveThemeType(newThemeType);

      // 成功したら新しい状態を設定
      state = AsyncValue<TLThemeType>.data(newThemeType);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<TLThemeType>.error(e, stack).copyWithPrevious(state);
    }
  }

  // アクセントカラーを変更
  // 注: アクセントカラーの変更はユーザーデータで管理するため、
  // このメソッドは実際にはテーマを変更しません。
  // ユーザーデータのプロバイダーと連携して使用します。
  Future<void> changeAccentColor(Color accentColor) async {
    TLVibrationService.vibrate();
    // テーマは変更せず、現在のテーマをそのまま返す
    // 実際のアクセントカラーの変更はユーザーデータのプロバイダーで行う
  }
}
