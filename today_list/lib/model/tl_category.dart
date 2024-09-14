import 'package:today_list/model/externals/tl_widgetkit.dart';

import 'workspace/workspace.dart';
import 'workspace/id_to_jsonworkspaceList.dart';
import 'todo/tl_todos.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TLCategory {
  String id;
  String title;

  TLCategory({
    required this.id,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
    };
  }

  TLCategory.fromJson(Map<String, dynamic> jsonData)
      : id = jsonData["id"],
        title = jsonData["title"];

  int getNumberOfToDosInThisCategory() {
    final TLToDos selectedToDos = currentWorkspace.toDos[id]!;
    return selectedToDos.toDosInToday.length +
        selectedToDos.toDosInWhenever.length;
  }

// --- save ---

  static void saveBigAndSmallCategories() {
    final jsonCurrentWorkspace = idToJsonWorkspaceList[
        currentWorkspaceCategoryId]![currentWorkspaceIndex];
    jsonCurrentWorkspace["bigCategories"] = TLCategory.categoryArrayToJson(
        categoryArray: currentWorkspace.bigCategories);
    jsonCurrentWorkspace["smallCategories"] = TLCategory.smallCategoriesToJson(
        smallCategories: currentWorkspace.smallCategories);
    SharedPreferences.getInstance().then((pref) {
      pref.setString("stringWorkspaces", json.encode(idToJsonWorkspaceList));
    });
  }

  static void saveBigCategories() {
    // currentWorkspaceのbigCategoriesに更新したものを入れる
    idToJsonWorkspaceList[currentWorkspaceCategoryId]![currentWorkspaceIndex]
            ["bigCategories"] =
        TLCategory.categoryArrayToJson(
            categoryArray: currentWorkspace.bigCategories);
    SharedPreferences.getInstance().then((pref) {
      pref.setString("stringWorkspaces", json.encode(idToJsonWorkspaceList));
    });
  }

  static void saveSmallCategories() {
    // currentWorkspaceのsmallCategoriesに更新したものを入れる
    idToJsonWorkspaceList[currentWorkspaceCategoryId]![currentWorkspaceIndex]
            ["smallCategories"] =
        TLCategory.smallCategoriesToJson(
            smallCategories: currentWorkspace.smallCategories);
    SharedPreferences.getInstance().then((pref) {
      pref.setString("stringWorkspaces", json.encode(idToJsonWorkspaceList));
    });
  }

  static Future<void> saveWorkspaceCategories() async {
    await SharedPreferences.getInstance().then((pref) {
      pref.setString(
          "workspaceCategories",
          json.encode(TLCategory.categoryArrayToJson(
              categoryArray: workspaceCategories)));
      // TLWidgetKit.updateWorkspaceCategories();
    });
  }

  static Future<void> readWorkspaceCategories() async {
    await SharedPreferences.getInstance().then((pref) {
      if (pref.getString("workspaceCategories") != null) {
        workspaceCategories = TLCategory.jsonToCategoryArray(
            jsonCategoryArrayData:
                json.decode(pref.getString("workspaceCategories")!));
      }
    });
  }

// --- save ---

  // リストを JSON に変換
  static List<Map<String, dynamic>> categoryArrayToJson(
      {required List<TLCategory> categoryArray}) {
    return categoryArray.map((cat) => cat.toJson()).toList();
  }

  // JSON をリストに変換
  static List<TLCategory> jsonToCategoryArray(
      {required List<dynamic> jsonCategoryArrayData}) {
    return jsonCategoryArrayData
        .map((item) => TLCategory.fromJson(item))
        .toList();
  }

  // --- smallCategories ---

  // Map を JSON に変換
  static Map<String, dynamic> smallCategoriesToJson(
      {required Map<String, List<TLCategory>> smallCategories}) {
    final Map<String, dynamic> encodedMap = {};
    smallCategories.forEach((bigCategoryIdData, categoriesData) {
      encodedMap[bigCategoryIdData] =
          categoriesData.map((categoryData) => categoryData.toJson()).toList();
    });
    return encodedMap;
  }

  // JSON を Map に変換
  static Map<String, List<TLCategory>> jsonToSmallCategories({
    required Map<String, dynamic> jsonSmallCategoriesData,
  }) {
    final Map<String, List<TLCategory>> result = {};

    jsonSmallCategoriesData
        .forEach((bigCategoryIdData, jsonSmallCategoriesData) {
      if (jsonSmallCategoriesData is List<dynamic>) {
        result[bigCategoryIdData] = jsonSmallCategoriesData
            .map((jsonSmallCategoryData) => TLCategory.fromJson(
                jsonSmallCategoryData as Map<String, dynamic>))
            .toList();
      } else {
        // JSON のデータ形式が不正な場合の処理
        print('Invalid format for key: $bigCategoryIdData');
        result[bigCategoryIdData] = [];
      }
    });

    return result;
  }
}
