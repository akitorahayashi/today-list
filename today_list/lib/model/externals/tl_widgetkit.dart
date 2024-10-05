import 'package:flutter/services.dart';
import 'package:today_list/model/user/setting_data.dart';
import 'package:today_list/model/workspace/tl_workspaces.dart';

import 'dart:convert';
import 'dart:io';

class TLWidgetKit {
  static const methodChannel = MethodChannel(
      'com.akitora0703.todaylist/show_todos_in_a_workspace_widget');

  // static Future<void> updateWorkspaceCategories() async {
  //   if (Platform.isIOS) {
  //     try {
  //       final String result = await methodChannel.invokeMethod(
  //         'updateWorkspaceCategories',
  //         json.encode(TLCategory.categoryArrayToJson(
  //             categoryArray: workspaceCategories)),
  //       );
  //       print('SET setUserDefaultsForAppGroup: $result');
  //     } on PlatformException catch (e) {
  //       print('ERROR setUserDefaultsData: ${e.message}');
  //     }
  //   }
  // }

  static Future<void> updateTLWorkspaces() async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateTLWorkspaces',
          json.encode(tlworkspaces),
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateSelectedTheme() async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateSelectedTheme',
          SettingData.shared.selectedTheme,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }
}
