import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/external/tl_vibration.dart';
import '../../../../view_model/todo/editing_provider/editing_todo_provider.dart';
import '../../../styles.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepTitleInputField extends ConsumerStatefulWidget {
  const StepTitleInputField({super.key});

  @override
  ConsumerState<StepTitleInputField> createState() =>
      StepTitleInputFieldState();
}

class StepTitleInputFieldState extends ConsumerState<StepTitleInputField> {
  String _enteredStepTitle = "";
  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EditingTodo editingTodo = ref.watch(editingToDoProvider);
    // notifier
    final EditingToDoNotifier editingToDoNotifier =
        ref.read(editingToDoProvider.notifier);
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          autofocus: true,
          controller: EditingTodo.stepTitleInputController,
          onChanged: (t) {
            setState(() {
              _enteredStepTitle = t;
            });
          },
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6)),
          cursorColor: tlThemeData.accentColor,
          decoration: tlInputDecoration(
              context: context,
              labelText: "Step",
              icon: Icon(
                FontAwesomeIcons.square,
                color: Colors.black.withOpacity(0.35),
              ),
              suffixIcon: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _enteredStepTitle.trim().isNotEmpty ? 1 : 0.25,
                child: TextButton(
                  // edittingToDoのstepsに追加
                  onPressed: _enteredStepTitle.trim().isEmpty
                      ? null
                      : () {
                          // add or edit
                          editingToDoNotifier.addToStepList(
                            _enteredStepTitle,
                            editingTodo.indexOfEditingStep,
                          );
                          TLVibration.vibrate();
                          EditingTodo.stepTitleInputController?.clear();
                          editingToDoNotifier.updateEditingTodo(
                            smallCategoryID: editingTodo.smallCategoryID,
                            indexOfEditingToDo: editingTodo.indexOfEditingToDo,
                            indexOfEditingStep: null,
                          );
                        },
                  child: Icon(
                    editingTodo.indexOfEditingStep == null
                        ? Icons.add
                        : Icons.edit,
                    color: _enteredStepTitle.trim().isNotEmpty
                        ? tlThemeData.accentColor
                        : Colors.black,
                    size: 25,
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
