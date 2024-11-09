import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/editting_provider/editting_todo_provider.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../styles/styles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToDoTitleInputField extends ConsumerWidget {
  const ToDoTitleInputField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EdittingTodo edittingTodo = ref.watch(edittingToDoProvider);
    // notifier
    final EditingToDoNotifier edittingToDoNotifier =
        ref.read(edittingToDoProvider.notifier);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        autofocus: true,
        controller: edittingTodo.toDoTitleInputController,
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
              opacity: edittingTodo.toDoTitleInputController?.text.isNotEmpty ??
                      false
                  ? 1
                  : 0.25,
              child: TextButton(
                onPressed: () => edittingToDoNotifier.completeEditting(),
                child: Icon(
                  Icons.add,
                  color:
                      edittingTodo.toDoTitleInputController?.text.isNotEmpty ??
                              false
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
