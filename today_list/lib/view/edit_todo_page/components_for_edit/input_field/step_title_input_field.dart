import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/editting_provider/editting_todo_provider.dart';
import '../../../../styles/styles.dart';
import '../../../../model/design/tl_theme.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StepTitleInputField extends ConsumerWidget {
  const StepTitleInputField({super.key});
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
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: TextField(
          autofocus: true,
          controller: edittingTodo.stepTitleInputController,
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
                opacity:
                    edittingTodo.stepTitleInputController?.text.isNotEmpty ??
                            false
                        ? 1
                        : 0.25,
                child: TextButton(
                  // edittingToDoのstepsに追加
                  onPressed: () {
                    final stepTitle =
                        edittingTodo.stepTitleInputController?.text;
                    if (stepTitle == null || stepTitle.isEmpty == true) return;
                    // add or edit
                    edittingToDoNotifier.addToStepList(
                        stepTitle, edittingTodo.indexOfEditingStep);
                    edittingTodo.stepTitleInputController?.clear();
                  },
                  child: Icon(
                    Icons.add,
                    color: edittingTodo
                                .stepTitleInputController?.text.isNotEmpty ??
                            false
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
