import 'package:flutter/material.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos.dart';

class TLToDosUtils {
  /// チェック済みのToDoおよびStepをカウント
  static int countCheckedToDosAndSteps(TLToDos selectedToDos) {
    int counter = 0;

    // 「今日」のカウント
    counter += _countInList(selectedToDos.toDosInToday);

    // 「いつでも」のカウント
    counter += _countInList(selectedToDos.toDosInWhenever);

    return counter;
  }

  /// 指定されたToDoリスト内のカウント処理
  static int _countInList(List<TLToDo> todos) {
    int counter = 0;

    for (TLToDo todo in todos) {
      if (todo.steps.isEmpty) {
        if (todo.isChecked) {
          counter++;
        }
      } else {
        for (final step in todo.steps) {
          if (step.isChecked) {
            counter++;
          }
        }
      }
    }

    return counter;
  }
}
