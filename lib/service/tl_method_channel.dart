import 'package:flutter/services.dart';
import 'dart:io';

import 'package:today_list/resource/tl_theme_type.dart';

class TLMethodChannelService {
  static const methodChannel = MethodChannel(
      'com.akitora0703.todaylist/show_todos_in_a_workspace_widget');

  static Future<void> updateTLWorkspaces(
      {required String encodedTLWorkspaces}) async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateTLWorkspaces',
          encodedTLWorkspaces,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateWKSList({required String encodedWKSList}) async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateWKSList',
          encodedWKSList,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateSelectedTheme(
      {required TLThemeType selectedThemeType}) async {
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
// git add .;git commit -m "WidgetExtentionでthemeIndexを基本にした管理をやめて、themeNameを基本にした管理に変更した”