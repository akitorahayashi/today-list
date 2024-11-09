import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/editing_provider/editing_todo_provider.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../styles/styles.dart';

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
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EditingTodo edittingTodo = ref.watch(edittingToDoProvider);
    // notifier
    final EditingToDoNotifier edittingToDoNotifier =
        ref.read(edittingToDoProvider.notifier);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        autofocus: true,
        controller: EditingTodo.toDoTitleInputController,
        onChanged: (s) {
          setState(() {
            _enteredToDoTitle = s;
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
                    : () => edittingToDoNotifier.completeEditting(),
                child: Icon(
                  Icons.add,
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
