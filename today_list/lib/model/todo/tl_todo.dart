import 'tl_step.dart';

class TLToDo {
  // static int numberOfComplitedToDos = 0;

  // todo別のメンバー
  String title;

  bool isChecked;
  List<TLStep> steps;

// コンストラクタ
  TLToDo({
    required this.title,
    this.isChecked = false,
    required this.steps,
  });

  // チェックの状態が変わったtodoの位置を変える関数
  static void reorderWhenToggle(
      {required String categoryId,
      required int indexOfThisToDoInToDos,
      required List<TLToDo> toDoArrayOfThisToDo}) async {
    //  = widget.selectedWorkspace.toDos[categoryId]!
    //     .getToDoArray(inToday: widget.ifInToday);
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

  // 保存する際に使う
  Map<String, dynamic> toJson() {
    return {
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
      title: jsonData["title"],
      isChecked: jsonData["isChecked"] ?? false,
      steps: stepsData.map((stepData) => TLStep.fromJson(stepData)).toList(),
    );
  }
}
