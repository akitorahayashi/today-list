import 'tl_todo.dart';
import 'tl_step.dart';

class TLToDos {
  List<TLToDo> toDosInToday;
  List<TLToDo> toDosInWhenever;

  TLToDos({required this.toDosInToday, required this.toDosInWhenever});

  List<TLToDo> getToDoArray({required bool inToday}) {
    if (inToday) {
      return toDosInToday;
    } else {
      return toDosInWhenever;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "toDosInToday": toDosInToday.map((todo) {
        return todo.toJson();
      }).toList(),
      "toDosInWhenever": toDosInWhenever.map((todo) {
        return todo.toJson();
      }).toList(),
    };
  }

  factory TLToDos.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    List<dynamic> todayData = jsonData["toDosInToday"] ?? [];
    List<dynamic> wheneverData = jsonData["toDosInWhenever"] ?? [];

    return TLToDos(
      toDosInToday: todayData.map((item) => TLToDo.fromJson(item)).toList(),
      toDosInWhenever:
          wheneverData.map((item) => TLToDo.fromJson(item)).toList(),
    );
  }

  // 削除したtoDoの回数分だけ~したいというときに実行される関数
  // static void countDeletedToDo(
  //     {int? selectedWorkspaceIndex,
  //     Workspace? selectedWorkspace,
  //     required int numberOfDeletedToDo}) {
  //   // workspace の effort
  //   (selectedWorkspace ?? currentWorkspace).numberOfToDosHaveBeenDone +=
  //       numberOfDeletedToDo;
  // }

  int countCheckedToDosAndStepsInThisToDos({required TLToDos selectedToDos}) {
    int counter = 0;
    // 「今日」のカウント
    for (TLToDo todo in selectedToDos.toDosInToday) {
      if (todo.steps.isEmpty) {
        // todoのカウント
        if (todo.isChecked) {
          counter++;
        }
      } else {
        // stepのカウント
        for (TLStep step in todo.steps) {
          if (step.isChecked) {
            counter++;
          }
        }
      }
    }

    // 「いつでも」のカウント
    for (TLToDo todo in selectedToDos.toDosInWhenever) {
      if (todo.steps.isEmpty) {
        // todoのカウント
        if (todo.isChecked) {
          counter++;
        }
      } else {
        // stepのカウント
        for (TLStep step in todo.steps) {
          if (step.isChecked) {
            counter++;
          }
        }
      }
    }
    return counter;
  }
}
