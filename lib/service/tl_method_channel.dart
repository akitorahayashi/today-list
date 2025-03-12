import 'package:flutter/services.dart';
import 'dart:io';

import 'package:today_list/resource/tl_theme_type.dart';

class TCWiOSMethodChannelService {
  static const methodChannel = MethodChannel(
    'com.akitora0703.todaylist.methodChannel',
  );

  static Future<void> updateTLWorkspaces({
    required String encodedWorkspaces,
  }) async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateTLWorkspaces',
          encodedWorkspaces,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateListOfToDosInCategoryWidgetSettings({
    required String encodedListOfToDosInCategoryWidgetSettings,
  }) async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateListOfToDosInCategoryWidgetSettings',
          encodedListOfToDosInCategoryWidgetSettings,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateSelectedTheme({
    required TLThemeType selectedThemeType,
  }) async {
    if (Platform.isIOS) {
      print(selectedThemeType.name);
      try {
        final String result = await methodChannel.invokeMethod(
          'updateSelectedTheme',
          selectedThemeType.name,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }
}
