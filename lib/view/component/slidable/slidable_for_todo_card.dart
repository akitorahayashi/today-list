import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view_model/todo/tl_workspaces_state.dart';
import 'package:today_list/view/edit_todo_page/edit_todo_page.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_todos.dart';
import '../../../service/tl_vibration.dart';
import '../../../model/todo/tl_workspace.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends ConsumerWidget {
  final bool isForModelCard;
  // todo
  final TLToDo corrTLToDo;
  final int indexOfThisToDoInToDos;
  final bool ifInToday;
  // category
  final String bigCategoryID;
  final String? smallCategoryID;
  // child
  final Widget child;
  const SlidableForToDoCard({
    super.key,
    required this.isForModelCard,
    required this.corrTLToDo,
    required this.indexOfThisToDoInToDos,
    required this.ifInToday,
    // category
    required this.bigCategoryID,
    required this.smallCategoryID,
    // child
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace =
        ref.watch(tlWorkspacesStateProvider).currentWorkspace;
    // notifier
    final TLWorkspacesStateNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesStateProvider.notifier);
    // other
    final String corrCategoryID = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisToDoBelongs = currentTLWorkspace
        .categoryIDToToDos[corrCategoryID]!
        .getToDos(ifInToday);
    return Slidable(
      // チェックされていたらスライドできなくする
      enabled: !corrTLToDo.isChecked,
      startActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.2, children: [
        // editAction
        SlidableAction(
          // タップしたらクローズ
          autoClose: true,
          backgroundColor: tlThemeData.panelColor,
          foregroundColor: tlThemeData.accentColor,
          onPressed: (BuildContext context) async {
            // タップしたらこれをremoveする
            toDoArrayOfThisToDoBelongs.removeAt(indexOfThisToDoInToDos);
            TLVibrationService.vibrate();
            tlWorkspacesNotifier.updateCurrentWorkspace(
                updatedCurrentWorkspace: currentTLWorkspace.copyWith());
          },
          icon: Icons.remove,
        ),
      ]),
      // スライドして編集
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.6,
        children: [
          if (!isForModelCard)
            SlidableAction(
              autoClose: true,
              flex: 10,
              spacing: 8,
              backgroundColor: tlThemeData.panelColor,
              foregroundColor: tlThemeData.accentColor,
              onPressed: (BuildContext context) async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return EditToDoPage(
                          ifInToday: true,
                          selectedBigCategoryID: bigCategoryID,
                          selectedSmallCategoryID: smallCategoryID,
                          editedToDoTitle:
                              toDoArrayOfThisToDoBelongs[indexOfThisToDoInToDos]
                                  .title,
                          indexOfEdittedTodo: indexOfThisToDoInToDos);
                    },
                  ),
                );
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
            backgroundColor: tlThemeData.panelColor,
            foregroundColor: tlThemeData.accentColor,
            onPressed: (BuildContext context) {
              // タップしたらtodayとwheneverを切り替える
              final TLToDo switchedToDo =
                  toDoArrayOfThisToDoBelongs.removeAt(indexOfThisToDoInToDos);
              currentTLWorkspace.categoryIDToToDos[corrCategoryID]!
                  .getToDos(ifInToday)
                  .insert(0, switchedToDo);
              TLVibrationService.vibrate();
              NotifyTodoOrStepIsEditedSnackBar.show(
                  context: context,
                  newTitle: corrTLToDo.title,
                  newCheckedState: corrTLToDo.isChecked,
                  quickChangeToToday: !ifInToday);
              tlWorkspacesNotifier.updateCurrentWorkspace(
                  updatedCurrentWorkspace: currentTLWorkspace.copyWith());
            },
            icon: ifInToday ? Icons.schedule : Icons.light_mode,
            label: ifInToday ? "whenever" : "today",
          ),
        ],
      ),
      child: child,
    );
  }
}
