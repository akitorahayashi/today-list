import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/todo_card/tl_checkbox.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';

class NotifyTodoOrStepIsEditedSnackBar {
  // MARK: - Show SnackBar
  static void show({
    required BuildContext context,
    required String newTitle,
    required bool newCheckedState,
    required bool isToDoCard,
    required bool? quickChangeToToday,
  }) {
    final snackBar = _createSnackBar(
      context: context,
      newTitle: newTitle,
      newCheckedState: newCheckedState,
      isToDoCard: isToDoCard,
      quickChangeToToday: quickChangeToToday,
    );

    _displaySnackBar(context, snackBar);
  }

  // MARK: - Display SnackBar
  static void _displaySnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // MARK: - Create SnackBar
  static SnackBar _createSnackBar({
    required BuildContext context,
    required String newTitle,
    required bool newCheckedState,
    required bool isToDoCard,
    bool? quickChangeToToday,
  }) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - Common Colors
    final backgroundColor =
        isToDoCard ? tlThemeData.canTapCardColor : tlThemeData.whiteBasedColor;
    final accentColor = tlThemeData.accentColor;
    final titleColor = Colors.black.withOpacity(newCheckedState ? 0.3 : 0.6);

    return SnackBar(
      duration: const Duration(milliseconds: 900),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      content: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // MARK: - Quick Change Message
            if (quickChangeToToday != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    quickChangeToToday ? "to Today" : "to Whenever",
                    style: TextStyle(
                      color: accentColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            // MARK: - ToDo Info Row
            Padding(
              padding: EdgeInsets.only(
                  bottom: (quickChangeToToday != null ? 3.0 : 0)),
              child: Row(
                children: [
                  // MARK: - Checkbox
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Transform.scale(
                        scale: 1.2,
                        child: TLCheckBox(isChecked: newCheckedState),
                      ),
                    ),
                  ),

                  // MARK: - ToDo Title
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        newTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
