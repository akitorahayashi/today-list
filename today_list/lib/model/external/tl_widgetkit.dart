import 'package:flutter/services.dart';
import 'package:today_list/model/user/setting_data.dart';

import 'dart:convert';
import 'dart:io';

import 'package:today_list/model/workspace/tl_workspace.dart';

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

  static Future<void> updateTLWorkspaces(
      {required List<TLWorkspace> tlWorkspaces}) async {
    if (Platform.isIOS) {
      final List<dynamic> _jsonWorkspaces = tlWorkspaces.map((workspace) {
        workspace.toJson();
      }).toList();
      try {
        final String result = await methodChannel.invokeMethod(
          'updateTLWorkspaces',
          json.encode(_jsonWorkspaces),
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateSelectedTheme() async {
    if (Platform.isIOS) {
      print(SettingData.shared.selectedThemeIndex);
      try {
        final String result = await methodChannel.invokeMethod(
          'updateSelectedTheme',
          SettingData.shared.selectedThemeIndex,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }
}
