import 'package:today_list/model/externals/tl_widgetkit.dart';

import '../tl_category.dart';
import 'workspaces.dart';
import '../todo/tl_todos.dart';
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Workspace {
  static int currentWorkspaceIndex = 0;

  static Workspace get currentWorkspace =>
      Workspace.fromJson(workspaces[currentWorkspaceIndex]);

  String name;
  // effort
  // int numberOfToDosHaveBeenDone = 0;
  // int thirdDigidOfNumberOfToDosHaveBeenDone = 0;
  // todo
  List<TLCategory> bigCategories;
  Map<String, List<TLCategory>> smallCategories;
  Map<String, TLToDos> toDos;
  Workspace({
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

  factory Workspace.fromJson(Map<String, dynamic> jsonData) {
    return Workspace(
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
    required String selectedWorkspaceCategoryId,
    required int newWorkspaceIndex,
  }) async {
    return SharedPreferences.getInstance().then((pref) {
      pref.setString("currentWorkspaceCategoryId", currentWorkspaceCategoryId);
      pref.setInt("currentWorkspaceIndex", currentWorkspaceIndex);
    });
  }

  Future<void> changeCurrentWorkspace({
    required int newWorkspaceIndex,
  }) async {
    currentWorkspaceCategoryId = selectedWorkspaceCategoryId;
    currentWorkspaceIndex = newWorkspaceIndex;
    currentWorkspace = Workspace.fromJson(
        workspaces[selectedWorkspaceCategoryId]![newWorkspaceIndex]);
    await saveCurrentWorkspace(
        selectedWorkspaceCategoryId: selectedWorkspaceCategoryId,
        newWorkspaceIndex: newWorkspaceIndex);
  }

  // --- save ---
  static Future<void> readWorkspaces() async {
    await SharedPreferences.getInstance().then((pref) {
      currentWorkspaceCategoryId =
          pref.getString("currentWorkspaceCategoryId") ?? noneId;
      currentWorkspaceIndex = pref.getInt("currentWorkspaceIndex") ?? 0;
      if (pref.getString("idToJsonWorkspaceList") != null) {
        workspaces = (json.decode(pref.getString("idToJsonWorkspaceList")!)
                as Map<String, dynamic>)
            .map(
          (key, value) => MapEntry(
            key,
            (value as List<dynamic>)
                .map((item) => item as Map<String, dynamic>)
                .toList(),
          ),
        );
      }
    });
  }

  static Future<void> saveStringWorkspaces() async {
    // iosならばwidgetを更新する
    if (Platform.isIOS) TLWidgetKit.updateIdToJsonWorkspaceList();
    // string workspaceを保存する
    await SharedPreferences.getInstance().then((pref) =>
        pref.setString("idToJsonWorkspaceList", json.encode(workspaces)));
  }

  static Future<void> saveSelectedWorkspace({
    required String selectedWorkspaceCategoryId,
    required int selectedWorkspaceIndex,
    required Workspace selectedWorkspace,
  }) async {
    workspaces[selectedWorkspaceCategoryId]![selectedWorkspaceIndex] =
        currentWorkspace.toJson();
    await Workspace.saveStringWorkspaces();
  }
  // --- save ---
}
