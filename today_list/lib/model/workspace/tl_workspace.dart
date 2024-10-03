import 'package:today_list/model/externals/tl_widgetkit.dart';

import '../tl_category.dart';
import 'tl_workspaces.dart';
import '../todo/tl_todos.dart';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class TLWorkspace {
  static int currentWorkspaceIndex = 0;

  static TLWorkspace currentWorkspace =
      TLWorkspace.fromJson(tlworkspaces[currentWorkspaceIndex]);

  String name;
  // effort
  // int numberOfToDosHaveBeenDone = 0;
  // int thirdDigidOfNumberOfToDosHaveBeenDone = 0;
  // todo
  List<TLCategory> bigCategories;
  Map<String, List<TLCategory>> smallCategories;
  Map<String, TLToDos> toDos;
  TLWorkspace({
    required this.name,
    required this.bigCategories,
    required this.smallCategories,
    required this.toDos,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "bigCategories":
          TLCategory.categoryArrayToJson(categoryArray: bigCategories),
      "smallCategories":
          TLCategory.smallCategoriesToJson(smallCategories: smallCategories),
      "toDos": toDos.map((key, toDos) => MapEntry(key, toDos.toJson())),
    };
  }

  factory TLWorkspace.fromJson(Map<String, dynamic> jsonData) {
    return TLWorkspace(
      name: jsonData["name"] ?? "Unknown",
      bigCategories: TLCategory.jsonToCategoryArray(
          jsonCategoryArrayData: jsonData["bigCategories"]),
      smallCategories: TLCategory.jsonToSmallCategories(
        // _TypeError (type '_Map<String, dynamic>' is not a subtype of type 'String')
        jsonSmallCategoriesData: jsonData["smallCategories"]!,
      ),
      toDos: (jsonData["toDos"] as Map<String, dynamic>).map(
        (key, jsonTLToDosData) => MapEntry(
          key,
          TLToDos.fromJson(jsonTLToDosData as Map<String, dynamic>),
        ),
      ),
    );
  }

  bool checkIfThisWorkspaceContainsToDoInToday() {
    for (TLCategory bigCategory in bigCategories) {
      if (toDos[bigCategory.id]!.toDosInToday.isNotEmpty) {
        return true;
      }
      for (TLCategory smallCategory in smallCategories[bigCategory.id]!) {
        if (toDos[smallCategory.id]!.toDosInToday.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }

  Future<void> saveCurrentWorkspace({
    required int newWorkspaceIndex,
  }) async {
    return SharedPreferences.getInstance().then((pref) {
      pref.setInt("currentWorkspaceIndex", TLWorkspace.currentWorkspaceIndex);
    });
  }

  Future<void> changeCurrentWorkspace({
    required int newWorkspaceIndex,
  }) async {
    TLWorkspace.currentWorkspaceIndex = newWorkspaceIndex;
    await saveCurrentWorkspace(newWorkspaceIndex: newWorkspaceIndex);
  }

  // --- save ---
  static Future<void> readWorkspaces() async {
    await SharedPreferences.getInstance().then((pref) {
      currentWorkspaceIndex = pref.getInt("currentWorkspaceIndex") ?? 0;
      if (pref.getString("tlworkspaces") != null) {
        tlworkspaces = json
            .decode(pref.getString("tlworkspaces")!)
            .map((item) => item as Map<String, dynamic>)
            .toList();
      }
    });
  }

  static Future<void> saveWorkspaces() async {
    // iosならばwidgetを更新する
    if (Platform.isIOS) TLWidgetKit.updateTLWorkspaces();
    // string workspaceを保存する
    await SharedPreferences.getInstance().then((pref) =>
        pref.setString("idToJsonWorkspaceList", json.encode(tlworkspaces)));
  }

  static Future<void> saveSelectedWorkspace({
    required int selectedWorkspaceIndex,
    required TLWorkspace selectedWorkspace,
  }) async {
    tlworkspaces[selectedWorkspaceIndex] = currentWorkspace.toJson();
    await TLWorkspace.saveWorkspaces();
  }
  // --- save ---
}
