import 'package:flutter/material.dart';
import 'todo/tl_category.dart';
import 'todo/tl_todos.dart';

class TLWorkspace {
  String id;
  String name;
  // todo
  List<TLCategory> bigCategories;
  Map<String, List<TLCategory>> smallCategories;
  Map<String, TLToDos> categoryIDToToDos;
  TLWorkspace({
    required this.id,
    required this.name,
    required this.bigCategories,
    required this.smallCategories,
    required this.categoryIDToToDos,
  });

  TLWorkspace copyWith({
    String? id,
    String? name,
    List<TLCategory>? bigCategories,
    Map<String, List<TLCategory>>? smallCategories,
    Map<String, TLToDos>? categoryIDToToDos,
  }) {
    return TLWorkspace(
      id: id ?? this.id,
      name: name ?? this.name,
      bigCategories: bigCategories ?? this.bigCategories,
      smallCategories: smallCategories ?? this.smallCategories,
      categoryIDToToDos: categoryIDToToDos ?? this.categoryIDToToDos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "bigCategories":
          TLCategory.categoryArrayToJson(categoryArray: bigCategories),
      "smallCategories":
          TLCategory.smallCategoriesToJson(smallCategories: smallCategories),
      "categoryIDToToDos":
          categoryIDToToDos.map((key, toDos) => MapEntry(key, toDos.toJson())),
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
      categoryIDToToDos:
          (jsonData["categoryIDToToDos"] as Map<String, dynamic>).map(
        (key, jsonTLToDosData) => MapEntry(
          key,
          TLToDos.fromJson(jsonTLToDosData as Map<String, dynamic>),
        ),
      ),
    );
  }

  bool checkIfThisWorkspaceContainsToDoInToday() {
    for (TLCategory bigCategory in bigCategories) {
      if (categoryIDToToDos[bigCategory.id]!.toDosInToday.isNotEmpty) {
        return true;
      }
      for (TLCategory smallCategory in smallCategories[bigCategory.id]!) {
        if (categoryIDToToDos[smallCategory.id]!.toDosInToday.isNotEmpty) {
          return true;
        }
      }
    }
    return false;
  }
}
