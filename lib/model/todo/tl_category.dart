import 'package:today_list/model/todo/tl_todos.dart';

class TLCategory {
  String id;
  String title;

  TLCategory({
    required this.id,
    required this.title,
  });

  TLCategory copyWith({
    String? id,
    String? title,
  }) {
    return TLCategory(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
    };
  }

  factory TLCategory.fromJson(Map<String, dynamic> jsonData) {
    return TLCategory(
      id: jsonData["id"],
      title: jsonData["title"],
    );
  }

  // このカテゴリーに含まれるToDoの数を返す
  int getNumberOfToDosInThisCategory(
      {required bool? ifInToday, required TLToDos corrToDos}) {
    if (ifInToday == null) {
      final int count = corrToDos[true].length + corrToDos[false].length;
      return count;
    } else {
      final int count = corrToDos[ifInToday].length;
      return count;
    }
  }

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
