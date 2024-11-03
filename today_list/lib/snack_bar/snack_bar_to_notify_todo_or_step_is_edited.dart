import 'package:flutter/material.dart';
import 'package:today_list/components/todo_card/icon_for_checkbox.dart';
import 'package:today_list/model/design/tl_theme.dart';

class NotifyTodoOrStepIsEditedSnackBar {
  static void show({
    required BuildContext context,
    required String newTitle,
    required bool newCheckedState,
    required bool? quickChangeToToday,
  }) {
    final SnackBar snackBar = _createSnackBar(
      context: context,
      newTitle: newTitle,
      newCheckedState: newCheckedState,
      quickChangeToToday: quickChangeToToday,
    );
    // スナックバーが表示されていたら消す
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static SnackBar _createSnackBar({
    required BuildContext context,
    required String newTitle,
    required bool newCheckedState,
    bool? quickChangeToToday,
  }) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return SnackBar(
      duration: const Duration(milliseconds: 900),
      behavior: SnackBarBehavior.floating,
      backgroundColor: _tlThemeData.panelColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (quickChangeToToday != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  quickChangeToToday ? "to Today" : "to Whenever",
                  style: TextStyle(
                      color: _tlThemeData.accentColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          // 選択した日があれば表示
          // if (scheduledDate != null)
          //   Padding(
          //     padding: const EdgeInsets.only(bottom: 8),
          //     child: Align(
          //         alignment: Alignment.bottomLeft,
          //         child: Text(
          //           scheduledDate,
          //           style: TextStyle(
          //               color: theme[settingData.selectedTheme]!
          //                   .accentColor
          //                   .withOpacity(0.9),
          //               fontWeight: FontWeight.w600,
          //               fontSize: 12),
          //         )),
          //   ),
          Padding(
            padding:
                EdgeInsets.only(bottom: (quickChangeToToday != null ? 3.0 : 0)),
            child: Row(
              children: [
                // 左側のチェックボックス
                Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                    // const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Transform.scale(
                        scale: 1.2,
                        child: TLCheckBox(isChecked: newCheckedState),
                      ),
                    )),
                // toDoのタイトル
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      newTitle,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                              .withOpacity(newCheckedState ? 0.3 : 0.5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
