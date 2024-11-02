import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/workspace/current_tl_workspace_provider.dart';
import '../model/workspace/tl_workspaces_provider.dart';
import '../model/tl_theme.dart';
import '../model/todo/tl_todo.dart';
import '../model/todo/tl_category.dart';
import '../model/external/tl_vibration.dart';
import '../model/workspace/tl_workspace.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends ConsumerWidget {
  final bool isModelCard;
  // todo
  final TLToDo toDoData;
  final List<TLToDo> toDoArrayOfThisToDo;
  final int indexOfThisToDoInToDos;
  final bool ifInToday;
  // category
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;
  // child
  final Function editAction;
  final Widget child;
  const SlidableForToDoCard({
    super.key,
    required this.isModelCard,
    required this.toDoData,
    required this.toDoArrayOfThisToDo,
    required this.indexOfThisToDoInToDos,
    required this.ifInToday,
    // category
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
    // workspace
    required this.editAction,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace _currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier _tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier _currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    // other
    final int _currentTLWorkspaceIndex =
        _currentTLWorkspaceNotifier.currentTLWorkspaceIndex;
    return Slidable(
      // チェックされていたらスライドできなくする
      enabled: !toDoData.isChecked,
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
