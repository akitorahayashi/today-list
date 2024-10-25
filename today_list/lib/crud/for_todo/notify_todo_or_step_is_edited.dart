import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../constants/icon_for_checkbox.dart';
import '../../model/user/setting_data.dart';

void notifyToDoOrStepIsEditted({
  required BuildContext context,
  required String newName,
  required bool newCheckedState,
  required bool? quickChangeToToday,
}) {
  SnackBar snackBar = SnackBar(
    duration: const Duration(milliseconds: 900),
    behavior: SnackBarBehavior.floating,
    backgroundColor:
        tlThemeDataList[SettingData.shared.selectedThemeIndex]!.panelColor,
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
                    color:
                        tlThemeDataList[SettingData.shared.selectedThemeIndex]!
                            .accentColor,
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
                      child: getIcon(isChecked: newCheckedState),
                    ),
                  )),
              // toDoのタイトル
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    newName,
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
  // スナックバーが表示されていたら消す
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
