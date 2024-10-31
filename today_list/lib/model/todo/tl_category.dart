import '../workspace/tl_workspace.dart';
import 'tl_todos.dart';
import '../external/tl_pref.dart';
import 'dart:convert';

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

// --- save ---

  static void saveBigAndSmallCategories() {
    final jsonCurrentWorkspace =
        _initialTLWorkspaces[TLWorkspace.currentWorkspaceIndex];
    jsonCurrentWorkspace["bigCategories"] = TLCategory.categoryArrayToJson(
        categoryArray: TLWorkspace.currentWorkspace.bigCategories);
    jsonCurrentWorkspace["smallCategories"] = TLCategory.smallCategoriesToJson(
        smallCategories: TLWorkspace.currentWorkspace.smallCategories);
    TLPref().getPref.then((pref) {
      pref.setString("stringWorkspaces", json.encode(_initialTLWorkspaces));
    });
  }

  static void saveBigCategories() {
    // currentWorkspaceのbigCategoriesに更新したものを入れる
    _initialTLWorkspaces[TLWorkspace.currentWorkspaceIndex]["bigCategories"] =
        TLCategory.categoryArrayToJson(
            categoryArray: TLWorkspace.currentWorkspace.bigCategories);
    TLPref().getPref.then((pref) {
      pref.setString("tlworkspaces", json.encode(_initialTLWorkspaces));
    });
  }

  static void saveSmallCategories() {
    // currentWorkspaceのsmallCategoriesに更新したものを入れる
    _initialTLWorkspaces[TLWorkspace.currentWorkspaceIndex]["smallCategories"] =
        TLCategory.smallCategoriesToJson(
            smallCategories: TLWorkspace.currentWorkspace.smallCategories);
    TLPref().getPref.then((pref) {
      pref.setString("tlworkspaces", json.encode(_initialTLWorkspaces));
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
