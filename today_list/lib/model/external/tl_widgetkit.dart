import 'package:today_list/model/tl_workspace.dart';
import 'package:flutter/services.dart';
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

  static Future<void> updateTLWorkspaces(
      {required List<TLWorkspace> tlWorkspaces}) async {
    if (Platform.isIOS) {
      final List<dynamic> jsonWorkspaces = tlWorkspaces.map((workspace) {
        workspace.toJson();
      }).toList();
      try {
        final String result = await methodChannel.invokeMethod(
          'updateTLWorkspaces',
          json.encode(jsonWorkspaces),
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }

  static Future<void> updateSelectedTheme(
      {required int selectedThemeIndex}) async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateSelectedTheme',
          selectedThemeIndex,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }
}
