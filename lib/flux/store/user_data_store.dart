import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/settings_data/selected_check_box_icon_data.dart';
import 'package:today_list/model/settings_data/tl_user_data.dart';
import 'package:today_list/service/tl_pref.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/service/tl_method_channel.dart';

// ユーザーデータのプロバイダー
final userDataProvider = AsyncNotifierProvider<UserDataNotifier, TLUserData>(
  UserDataNotifier.new,
);

// 選択されたチェックボックスアイコンのプロバイダー
final selectedCheckBoxIconProvider = Provider<SelectedCheckBoxIconData>((ref) {
  final userDataAsync = ref.watch(userDataProvider);
  return userDataAsync.whenData((userData) {
        return userData.selectedCheckBoxIconData;
      }).valueOrNull ??
      const SelectedCheckBoxIconData(iconCategory: "Default", iconName: "Box");
});

// ユーザーデータを管理するNotifier
class UserDataNotifier extends AsyncNotifier<TLUserData> {
  static const _prefKey = 'tlUserData';

  @override
  Future<TLUserData> build() async {
    return _loadUserData();
  }

  Future<TLUserData> _loadUserData() async {
    final pref = await TLPrefService().getPref;
    final jsonString = pref.getString(_prefKey);

    if (jsonString != null) {
      try {
        final jsonData = jsonDecode(jsonString);
        return TLUserData.fromJson(jsonData);
      } catch (e) {
        // デフォルトのユーザーデータを返す
        return _getDefaultUserData();
      }
    }

    // デフォルトのユーザーデータを返す
    return _getDefaultUserData();
  }

  TLUserData _getDefaultUserData() {
    return const TLUserData(
      currentAppIconName: "Notebook",
      selectedCheckBoxIconData: SelectedCheckBoxIconData(
        iconCategory: "Default",
        iconName: "Box",
      ),
      earnedCheckBoxIcons: {
        "Default": ["Box", "Circle"],
      },
    );
  }

  Future<void> _saveUserData(TLUserData userData) async {
    final pref = await TLPrefService().getPref;
    final jsonString = jsonEncode(userData.toJson());
    await pref.setString(_prefKey, jsonString);
  }

  // アプリアイコンを変更
  Future<void> updateCurrentAppIconName(String newThemeName) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<TLUserData>.loading().copyWithPrevious(state);

    try {
      final currentData = await future;

      try {
        // Call MethodChannel to change the icon natively on iOS
        await TCWiOSMethodChannelService.changeAppIcon(iconName: newThemeName);
      } catch (e) {
        // Log error but don't necessarily block state update
        print("MethodChannel call to changeAppIcon failed: $e");
      }

      final updatedData = currentData.copyWith(
        currentAppIconName: newThemeName,
      );
      await _saveUserData(updatedData);

      // 成功したら新しい状態を設定
      state = AsyncValue<TLUserData>.data(updatedData);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<TLUserData>.error(e, stack).copyWithPrevious(state);
    }
  }

  // チェックボックスアイコンを変更
  Future<void> updateSelectedCheckBoxIcon(
    SelectedCheckBoxIconData newCheckBox,
  ) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<TLUserData>.loading().copyWithPrevious(state);

    try {
      final currentData = await future;
      final updatedData = currentData.copyWith(
        selectedCheckBoxIconData: newCheckBox,
      );
      await _saveUserData(updatedData);

      // 成功したら新しい状態を設定
      state = AsyncValue<TLUserData>.data(updatedData);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<TLUserData>.error(e, stack).copyWithPrevious(state);
    }
  }

  // 獲得したチェックボックスアイコンを追加
  Future<void> updateEarnedIcons(String iconCategory, String iconName) async {
    TLVibrationService.vibrate();

    // 現在の状態を保持しながらローディング状態に
    state = const AsyncValue<TLUserData>.loading().copyWithPrevious(state);

    try {
      final currentData = await future;
      final newEarnedIcons = Map<String, List<String>>.from(
        currentData.earnedCheckBoxIcons,
      );

      if (newEarnedIcons[iconCategory] == null) {
        newEarnedIcons[iconCategory] = [iconName];
      } else {
        final existingIcons = List<String>.from(newEarnedIcons[iconCategory]!);
        if (!existingIcons.contains(iconName)) {
          existingIcons.add(iconName);
        }
        newEarnedIcons[iconCategory] = existingIcons;
      }

      final updatedData = currentData.copyWith(
        earnedCheckBoxIcons: newEarnedIcons,
      );
      await _saveUserData(updatedData);

      // 成功したら新しい状態を設定
      state = AsyncValue<TLUserData>.data(updatedData);
    } catch (e, stack) {
      // エラー時も前の状態を保持
      state = AsyncValue<TLUserData>.error(e, stack).copyWithPrevious(state);
    }
  }
}
