import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todos.dart';

class TLCategoryUtils {
  // このカテゴリーに含まれるToDoの数を返す
  static int getNumberOfToDosInThisCategory(
      {required bool? ifInToday, required TLToDos corrToDos}) {
    if (ifInToday == null) {
      final int count = corrToDos[true].length + corrToDos[false].length;
      return count;
    } else {
      final int count = corrToDos[ifInToday].length;
      return count;
    }
  }

  // カテゴリー配列を JSON に変換
  static List<Map<String, dynamic>> categoryArrayToJson(
      {required List<TLCategory> categoryArray}) {
    return categoryArray.map((cat) => cat.toJson()).toList();
  }

  // JSON をカテゴリー配列に変換
  static List<TLCategory> jsonToCategoryArray(
      {required List<dynamic> jsonCategoryArrayData}) {
    return jsonCategoryArrayData
        .map((item) => TLCategory.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // Map を JSON に変換
  static Map<String, dynamic> smallCategoriesToJson(
      {required Map<String, List<TLCategory>> smallCategories}) {
    final Map<String, dynamic> encodedMap = {};
    smallCategories.forEach((bigCategoryId, categories) {
      encodedMap[bigCategoryId] =
          categories.map((category) => category.toJson()).toList();
    });
    return encodedMap;
  }

  // JSON を Map に変換
  static Map<String, List<TLCategory>> jsonToSmallCategories({
    required Map<String, dynamic> jsonSmallCategoriesData,
  }) {
    final Map<String, List<TLCategory>> result = {};

    jsonSmallCategoriesData.forEach((bigCategoryId, jsonCategories) {
      if (jsonCategories is List<dynamic>) {
        result[bigCategoryId] = jsonCategories
            .map((jsonCategory) =>
                TLCategory.fromJson(jsonCategory as Map<String, dynamic>))
            .toList();
      } else {
        print('Invalid format for key: $bigCategoryId');
        result[bigCategoryId] = [];
      }
    });

    return result;
  }
}
