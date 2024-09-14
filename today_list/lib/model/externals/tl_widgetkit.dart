import 'package:flutter/services.dart';
import 'package:today_list/model/tl_category.dart';
import 'package:today_list/model/user/setting_data.dart';
import 'package:today_list/model/workspace/id_to_jsonworkspaceList.dart';

import 'dart:convert';
import 'dart:io';

class TLWidgetKit {
  static const methodChannel =
      MethodChannel('com.akitora0703.todaylist/sample');

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

  static Future<void> updateIdToJsonWorkspaceList() async {
    if (Platform.isIOS) {
      try {
        final String result = await methodChannel.invokeMethod(
          'updateIdToJsonWorkspaceList',
          json.encode(idToJsonWorkspaceList),
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
          settingData.selectedTheme,
        );
        print('SET setUserDefaultsForAppGroup: $result');
      } on PlatformException catch (e) {
        print('ERROR setUserDefaultsData: ${e.message}');
      }
    }
  }
}
