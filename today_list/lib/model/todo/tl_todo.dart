import 'package:flutter/material.dart';
import './tl_category.dart';
import './tl_step.dart';

class TLToDo {
  // todo別のメンバー
  String id;
  String title;

  bool isChecked;
  List<TLStep> steps;

// コンストラクタ
  TLToDo({
    required this.id,
    required this.title,
    required this.steps,
    this.isChecked = false,
  });

  // チェックの状態が変わったtodoの位置を変える関数
  // static void reorderWhenToggle(
  //     {required String categoryId,
  //     required int indexOfThisToDoInToDos,
  //     required List<TLToDo> toDoArrayOfThisToDo}) async {
  //   //  = widget.selectedWorkspace.toDos[categoryId]!
  //   //     .getToDoArray(inToday: widget.ifInToday);
  //   final TLToDo toDoCheckStateHasChanged =
  //       toDoArrayOfThisToDo.removeAt(indexOfThisToDoInToDos);
  //   final int indexOfCheckedToDo =
  //       toDoArrayOfThisToDo.indexWhere((todo) => todo.isChecked);
  //   if (indexOfCheckedToDo == -1) {
  //     toDoArrayOfThisToDo.add(toDoCheckStateHasChanged);
  //   } else {
  //     toDoArrayOfThisToDo.insert(indexOfCheckedToDo, toDoCheckStateHasChanged);
  //   }
  // }

  // 保存する際に使う
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "isChecked": isChecked,
      "steps": steps.map((step) {
        return step.toMap();
      }).toList(),
    };
  }

  factory TLToDo.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> stepsData = jsonData["steps"] ?? [];

    return TLToDo(
      id: jsonData["id"] ?? UniqueKey().toString(),
      title: jsonData["title"] ?? "",
      isChecked: jsonData["isChecked"] ?? false,
      steps: stepsData.map((stepData) => TLStep.fromJson(stepData)).toList(),
    );
  }

  static TLToDo getDefaultToDo() {
    return TLToDo(
      id: UniqueKey().toString(),
      title: '',
      steps: [],
      isChecked: false,
    );
  }

  TLToDo copyWith({
    String? id,
    String? title,
    List<TLStep>? steps,
    bool? isChecked,
    bool? isInToday,
    TLCategory? bigCategory,
    TLCategory? smallCategory,
  }) {
    return TLToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      steps: steps ?? this.steps,
      isChecked: isChecked ?? this.isChecked,
    );
  }
}
