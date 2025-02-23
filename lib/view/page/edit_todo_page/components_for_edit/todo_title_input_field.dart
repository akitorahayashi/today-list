import 'package:flutter/material.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class ToDoTitleInputField extends StatefulWidget {
  final TextEditingController toDoTitleController;
  final bool isEditing;
  final Future<void> Function() onCompleteEditing;

  const ToDoTitleInputField({
    super.key,
    required this.toDoTitleController,
    required this.isEditing,
    required this.onCompleteEditing,
  });

  @override
  State<ToDoTitleInputField> createState() => _ToDoTitleInputFieldState();
}

class _ToDoTitleInputFieldState extends State<ToDoTitleInputField> {
  String _enteredToDoTitle = "";

  @override
  void initState() {
    super.initState();
    _enteredToDoTitle = widget.toDoTitleController.text;
    widget.toDoTitleController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.toDoTitleController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _enteredToDoTitle = widget.toDoTitleController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        controller: widget.toDoTitleController,
        autofocus: true,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.6),
        ),
        cursorColor: tlThemeData.accentColor,
        decoration: tlInputDecoration(
          context: context,
          labelText: "ToDo",
          icon: Icon(
            FontAwesomeIcons.square,
            color: Colors.black.withOpacity(0.35),
          ),
          suffixIcon: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _enteredToDoTitle.trim().isNotEmpty ? 1 : 0.25,
            child: TextButton(
              onPressed: _enteredToDoTitle.trim().isEmpty
                  ? null
                  : () async {
                      // スナックバー
                      NotifyTodoOrStepIsEditedSnackBar.show(
                        context: context,
                        newTitle: _enteredToDoTitle,
                        newCheckedState: false,
                        isToDoCard: true,
                        quickChangeToToday: null,
                      );
                      TLVibrationService.vibrate();

                      // ToDo保存処理
                      await widget.onCompleteEditing();
                    },
              child: Icon(
                widget.isEditing ? Icons.edit : Icons.add,
                color: _enteredToDoTitle.trim().isNotEmpty
                    ? tlThemeData.accentColor
                    : Colors.black,
                size: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
