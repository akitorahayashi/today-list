import 'package:flutter/material.dart';
import 'package:today_list/model/external/tl_widgetkit.dart';
import 'package:today_list/model/external/tl_connectivity.dart';
import 'package:today_list/model/external/tl_pref.dart';
import '../todo/tl_category.dart';
import 'tl_workspace_notifier.dart';
import '../todo/tl_todos.dart';
import 'dart:convert';
import 'dart:io';

class TLWorkspace {
  static int currentWorkspaceIndex = 0;

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

  static Future<void> changeCurrentWorkspace({
    required int newWorkspaceIndex,
  }) async {
    TLWorkspace.currentWorkspaceIndex = newWorkspaceIndex;
    // TODO indexを変えただけでいいか
    await TLPref().getPref.then((pref) {
      pref.setInt("currentWorkspaceIndex", newWorkspaceIndex);
    });
  }

  static Future<void> saveWorkspaces() async {
    // iosならばwidgetを更新する
    if (Platform.isIOS) {
      TLWidgetKit.updateTLWorkspaces();
      TLConnectivity.sendTLWorkspacesToAppleWatch();
    }
    // string workspaceを保存する
    await TLPref().getPref.then((pref) =>
        pref.setString("tlworkspaces", json.encode(_initialTLWorkspaces)));
  }

  static Future<void> saveSelectedWorkspace({
    required int selectedWorkspaceIndex,
  }) async {
    _initialTLWorkspaces[selectedWorkspaceIndex] = currentWorkspace.toJson();
    await TLWorkspace.saveWorkspaces();
  }
  // --- save ---
}
