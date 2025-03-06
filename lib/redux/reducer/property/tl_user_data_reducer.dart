import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';

class TLUserDataReducer {
  static Future<TLUserData> reduce(
      TLUserData state, TLUserDataAction action) async {
    return await action.map(
      updateCurrentAppIconName: (a) =>
          _updateCurrentAppIconName(state, a.newThemeName),
      updateSelectedCheckBoxIcon: (a) =>
          _updateSelectedCheckBoxIcon(state, a.newCheckBox),
      updateEarnedIcons: (a) =>
          _updateEarnedIcons(state, a.iconCategory.name, a.iconName.name),
      saveCustomAccentColor: (a) =>
          _saveCustomAccentColor(state, a.newAccentColor),
    );
  }

  // アプリのアイコンを変更
  static Future<TLUserData> _updateCurrentAppIconName(
      TLUserData state, String newThemeName) async {
    try {
      if (await FlutterDynamicIcon.supportsAlternateIcons) {
        await FlutterDynamicIcon.setAlternateIconName(newThemeName,
            showAlert: false);
        print('Icon changed to: $newThemeName');
      } else {
        print("Dynamic icon change is not supported on this device.");
      }
    } catch (e) {
      print("Failed to change icon: $e");
    }
    return state.copyWith(currentAppIconName: newThemeName);
  }

  // チェックボックスのアイコンを変更
  static TLUserData _updateSelectedCheckBoxIcon(
      TLUserData state, SelectedCheckBoxIconData newCheckBox) {
    return state.copyWith(selectedCheckBoxIconData: newCheckBox);
  }

  // 獲得したアイコンを更新
  static TLUserData _updateEarnedIcons(
      TLUserData state, String iconCategory, String iconName) {
    final newEarnedIcons =
        Map<String, List<String>>.from(state.earnedCheckBoxIcons);

    if (newEarnedIcons[iconCategory] == null) {
      newEarnedIcons[iconCategory] = [iconName];
    } else {
      final existingIcons = List<String>.from(newEarnedIcons[iconCategory]!);
      if (!existingIcons.contains(iconName)) {
        existingIcons.add(iconName);
      }
      newEarnedIcons[iconCategory] = existingIcons;
    }

    return state.copyWith(earnedCheckBoxIcons: newEarnedIcons);
  }

  // カスタムアクセントカラーを保存
  static TLUserData _saveCustomAccentColor(
      TLUserData state, Color accentColor) {
    // カラーの値を保存
    return state.copyWith(customAccentColorValue: accentColor.value);
  }
}
