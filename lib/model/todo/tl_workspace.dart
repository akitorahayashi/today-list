import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/utils/tl_category_utils.dart';
import '../todo/tl_category.dart';
import '../todo/tl_todos.dart';

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
          TLCategoryUtils.categoryArrayToJson(categoryArray: bigCategories),
      "smallCategories": TLCategoryUtils.smallCategoriesToJson(
          smallCategories: smallCategories),
      "categoryIDToToDos":
          categoryIDToToDos.map((key, toDos) => MapEntry(key, toDos.toJson())),
    };
  }

  factory TLWorkspace.fromJson(Map<String, dynamic> jsonData) {
    return TLWorkspace(
      id: jsonData["id"] ?? UniqueKey().toString(),
      name: jsonData["name"] ?? "Unknown",
      bigCategories: TLCategoryUtils.jsonToCategoryArray(
          jsonCategoryArrayData: jsonData["bigCategories"]),
      smallCategories: TLCategoryUtils.jsonToSmallCategories(
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

  int getNumOfToDo({required bool ifInToday}) {
    int todoCount = 0;
    for (TLCategory bigCategory in bigCategories) {
      todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
          ifInToday: ifInToday, corrToDos: categoryIDToToDos[bigCategory.id]!);
      for (TLCategory smallCategory in smallCategories[bigCategory.id]!) {
        todoCount += TLCategoryUtils.getNumberOfToDosInThisCategory(
            ifInToday: ifInToday,
            corrToDos: categoryIDToToDos[smallCategory.id]!);
      }
    }
    return todoCount;
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

  Future<void> deleteCheckedToDosInTodayInAWorkspace(
      {required bool onlyToday}) async {
    for (TLCategory bigCategory in bigCategories) {
      deleteAllCheckedToDosInAToDos(
        onlyToday: onlyToday,
        selectedToDos: categoryIDToToDos[bigCategory.id]!,
      );
      for (TLCategory smallCategory in smallCategories[bigCategory.id]!) {
        deleteAllCheckedToDosInAToDos(
          onlyToday: onlyToday,
          selectedToDos: categoryIDToToDos[smallCategory.id]!,
        );
      }
    }
  }

  void deleteAllCheckedToDosInAToDos({
    required bool onlyToday,
    required TLToDos selectedToDos,
  }) {
    selectedToDos.toDosInToday.removeWhere((todo) => todo.isChecked);
    for (TLToDo todo in selectedToDos.toDosInToday) {
      todo.steps.removeWhere((step) => step.isChecked);
    }
    if (!onlyToday) {
      selectedToDos.toDosInWhenever.removeWhere((todo) => todo.isChecked);
      for (TLToDo todo in selectedToDos.toDosInWhenever) {
        todo.steps.removeWhere((step) => step.isChecked);
      }
    }
  }

  void reorderWhenToggle({
    required String categoryId,
    required bool ifInToday,
    required int indexOfThisToDoInToDos,
  }) async {
    final toDoArrayOfThisToDo =
        categoryIDToToDos[categoryId]!.getToDos(ifInToday);
    final TLToDo toDoCheckStateHasChanged =
        toDoArrayOfThisToDo.removeAt(indexOfThisToDoInToDos);
    final int indexOfCheckedToDo =
        toDoArrayOfThisToDo.indexWhere((todo) => todo.isChecked);
    if (indexOfCheckedToDo == -1) {
      toDoArrayOfThisToDo.add(toDoCheckStateHasChanged);
    } else {
      toDoArrayOfThisToDo.insert(indexOfCheckedToDo, toDoCheckStateHasChanged);
    }
  }
}
