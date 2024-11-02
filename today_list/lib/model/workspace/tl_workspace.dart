import 'package:flutter/material.dart';
import '../todo/tl_category.dart';
import '../todo/tl_todos.dart';

class TLWorkspace {
  String id;
  String name;
  // todo
  List<TLCategory> bigCategories;
  Map<String, List<TLCategory>> smallCategories;
  Map<String, TLToDos> toDos;
  TLWorkspace({
    required this.id,
    required this.name,
    required this.bigCategories,
    required this.smallCategories,
    required this.toDos,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
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
      id: jsonData["id"] ?? UniqueKey().toString(),
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
}
