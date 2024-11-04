import 'package:flutter/material.dart';
import 'package:today_list/model/provider/editting_todo_provider.dart';
import '../../../../styles/styles.dart';
import '../../../../model/design/tl_theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToDoTitleInputField extends StatefulWidget {
  const ToDoTitleInputField({super.key});

  @override
  State<ToDoTitleInputField> createState() => _ToDoTitleInputFieldState();
}

class _ToDoTitleInputFieldState extends State<ToDoTitleInputField> {
  bool get isEntered => widget.controller.text.trim().isNotEmpty;
  final EditingToDoNotifier edittingToDoNotifier =
      ref.read(edittingToDoProvider.notifier);
  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: TextField(
        autofocus: true,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.6)),
        cursorColor: tlThemeData.accentColor,
        decoration: tlInputDecoration(
            context: context,
            labelText: widget.isForStep ? "Step" : "ToDo",
            icon: Icon(
              FontAwesomeIcons.square,
              color: Colors.black.withOpacity(0.35),
            ),
            suffixIcon: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isEntered ? 1 : 0.25,
              child: TextButton(
                onPressed: widget.onPressed,
                child: Icon(
                  Icons.add,
                  color: isEntered ? tlThemeData.accentColor : Colors.black,
                  size: 25,
                ),
              ),
            )),
      ),
    );
  }
}
