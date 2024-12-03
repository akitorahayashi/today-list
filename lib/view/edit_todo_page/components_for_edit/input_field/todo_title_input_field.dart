import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../../../model/external/tl_vibration.dart';
import '../../../../view_model/todo/editing_provider/editing_todo_provider.dart';
import '../../../../model/tl_theme.dart';
import '../../../styles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToDoTitleInputField extends ConsumerStatefulWidget {
  const ToDoTitleInputField({super.key});

  @override
  ConsumerState<ToDoTitleInputField> createState() =>
      ToDoTitleInputFieldState();
}

class ToDoTitleInputFieldState extends ConsumerState<ToDoTitleInputField> {
  String _enteredToDoTitle = "";

  @override
  void initState() {
    super.initState();
    _enteredToDoTitle = EditingTodo.toDoTitleInputController?.text ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final editingToDo = ref.watch(editingToDoProvider);
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        autofocus: true,
        controller: EditingTodo.toDoTitleInputController,
        onChanged: (t) {
          setState(() {
            _enteredToDoTitle = t;
          });
        },
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.6)),
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
                    : () {
                        NotifyTodoOrStepIsEditedSnackBar.show(
                            context: context,
                            newTitle: _enteredToDoTitle,
                            newCheckedState: false,
                            quickChangeToToday: null);
                        TLVibration.vibrate();
                        editingToDoNotifier.completeEditing();
                      },
                child: Icon(
                  editingToDo.indexOfEditingToDo == null
                      ? Icons.add
                      : Icons.edit,
                  color: _enteredToDoTitle.trim().isNotEmpty
                      ? tlThemeData.accentColor
                      : Colors.black,
                  size: 25,
                ),
              ),
            )),
      ),
    );
  }
}
