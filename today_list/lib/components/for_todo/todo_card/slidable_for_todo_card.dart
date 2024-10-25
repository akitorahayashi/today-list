import 'package:flutter/material.dart';
import '../../../model/tl_theme.dart';
import '../../../constants/global_keys.dart';
import '../../../crud/for_todo/notify_todo_or_step_is_edited.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/external/tl_vibration.dart';
import '../../../model/workspace/tl_workspace.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends StatefulWidget {
  final GlobalKey superKey;
  final bool isModelCard;
  // todo
  final TLToDo toDoData;
  final List<TLToDo> toDoArrayOfThisToDo;
  final int indexOfThisToDoInToDos;
  final bool ifInToday;
  // category
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;
  // workspace
  final int selectedWorkspaceIndex;
  final TLWorkspace selectedWorkspace;
  // child
  final Function editAction;
  final Widget child;
  const SlidableForToDoCard({
    super.key,
    required this.superKey,
    required this.isModelCard,
    required this.toDoData,
    required this.toDoArrayOfThisToDo,
    required this.indexOfThisToDoInToDos,
    required this.ifInToday,
    // category
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
    // workspace
    required this.selectedWorkspaceIndex,
    required this.selectedWorkspace,
    required this.editAction,
    required this.child,
  });

  @override
  State<SlidableForToDoCard> createState() => _SlidableForToDoCardState();
}

class _SlidableForToDoCardState extends State<SlidableForToDoCard> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Slidable(
      // チェックされていたらスライドできなくする
      enabled: !widget.toDoData.isChecked,
      startActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.2, children: [
        // editAction
        SlidableAction(
          // タップしたらクローズ
          autoClose: true,
          backgroundColor: _tlThemeData.panelColor,
          foregroundColor: _tlThemeData.accentColor,
          onPressed: (BuildContext context) async {
            // タップしたらこれをremoveする
            widget.toDoArrayOfThisToDo.removeAt(widget.indexOfThisToDoInToDos);
            TLVibration.vibrate();
            homePageKey.currentState?.setState(() {});
            editToDoPageKey.currentState?.setState(() {});
            TLWorkspace.saveSelectedWorkspace(
                selectedWorkspaceIndex: widget.selectedWorkspaceIndex);
          },
          icon: Icons.remove,
        ),
      ]),
      // スライドして編集
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.6,
        children: [
          if (!widget.isModelCard)
            SlidableAction(
              autoClose: true,
              flex: 10,
              spacing: 8,
              backgroundColor: _tlThemeData.panelColor,
              foregroundColor: _tlThemeData.accentColor,
              onPressed: (BuildContext context) async {
                widget.editAction();
              },
              icon: Icons.edit,
              label: 'Edit',
            ),
          // いつでもと今日を切り替える
          SlidableAction(
            // タップしたらクローズ
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: _tlThemeData.panelColor,
            foregroundColor: _tlThemeData.accentColor,
            onPressed: (BuildContext context) {
              // タップしたらtodayとwheneverを切り替える
              final TLToDo switchedToDo = widget.toDoArrayOfThisToDo
                  .removeAt(widget.indexOfThisToDoInToDos);
              widget
                  .selectedWorkspace
                  .toDos[widget.smallCategoryOfThisToDo?.id ??
                      widget.bigCategoryOfThisToDo.id]!
                  .getToDoArray(inToday: !widget.ifInToday)
                  .insert(0, switchedToDo);
              widget.superKey.currentState?.setState(() {});
              categoryListPageKey.currentState?.setState(() {});
              TLVibration.vibrate();
              notifyToDoOrStepIsEditted(
                context: context,
                newName: widget.toDoData.title,
                newCheckedState: widget.toDoData.isChecked,
                quickChangeToToday: !widget.ifInToday,
              );
              TLWorkspace.saveSelectedWorkspace(
                  selectedWorkspaceIndex: widget.selectedWorkspaceIndex);
            },
            icon: widget.ifInToday ? Icons.schedule : Icons.light_mode,
            label: widget.ifInToday ? "whenever" : "today",
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
