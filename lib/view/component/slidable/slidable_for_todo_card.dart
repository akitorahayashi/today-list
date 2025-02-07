import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/redux/action/todo/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/screen/edit_todo_page/edit_todo_page.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_todo.dart';
import '../../../model/todo/tl_todos_in_today_and_whenever.dart';
import '../../../service/tl_vibration.dart';
import '../../../model/todo/tl_workspace.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends ConsumerWidget {
  final bool isForModelCard;
  final TLToDo corrTLToDo;
  final int indexOfThisToDoInToDos;
  final bool ifInToday;
  final String bigCategoryID;
  final String? smallCategoryID;
  final Widget child;

  const SlidableForToDoCard({
    super.key,
    required this.isForModelCard,
    required this.corrTLToDo,
    required this.indexOfThisToDoInToDos,
    required this.ifInToday,
    required this.bigCategoryID,
    required this.smallCategoryID,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // notifier
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    // others
    final TLWorkspace currentWorkspaceRef =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex].copyWith();

    final String corrCategoryID = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisToDoBelongs = currentWorkspaceRef
        .categoryIDToToDos[corrCategoryID]!
        .getToDos(ifInToday);

    return Slidable(
      enabled: !corrTLToDo.isChecked,
      startActionPane:
          ActionPane(motion: const ScrollMotion(), extentRatio: 0.2, children: [
        SlidableAction(
          autoClose: true,
          backgroundColor: tlThemeData.panelColor,
          foregroundColor: tlThemeData.accentColor,
          onPressed: (BuildContext context) {
            // 新しいリストを生成
            final List<TLToDo> updatedToDos =
                List.from(toDoArrayOfThisToDoBelongs)
                  ..removeAt(indexOfThisToDoInToDos);

            // categoryIDToToDosを再構築
            final updatedCategoryIDToToDos = {
              ...currentWorkspaceRef.categoryIDToToDos,
              corrCategoryID: currentWorkspaceRef
                  .categoryIDToToDos[corrCategoryID]!
                  .copyWith(toDosInToday: updatedToDos),
            };

            // ワークスペースを更新
            tlAppStateReducer.dispatchWorkspaceAction(
                TLWorkspaceAction.updateCurrentWorkspace(
              currentWorkspaceRef.copyWith(
                categoryIDToToDos: updatedCategoryIDToToDos,
              ),
            ));

            TLVibrationService.vibrate();
          },
          icon: Icons.remove,
        ),
      ]),
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
              onPressed: (BuildContext context) {
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
                        indexOfEdittedTodo: indexOfThisToDoInToDos,
                      );
                    },
                  ),
                );
              },
              icon: Icons.edit,
              label: 'Edit',
            ),
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: tlThemeData.panelColor,
            foregroundColor: tlThemeData.accentColor,
            onPressed: (BuildContext context) {
              final TLToDo switchedToDo =
                  toDoArrayOfThisToDoBelongs[indexOfThisToDoInToDos];

              // toDosInTodayとtoDosInWheneverを切り替える
              final List<TLToDo> updatedToDosInCurrentList =
                  List.from(toDoArrayOfThisToDoBelongs)
                    ..removeAt(indexOfThisToDoInToDos);
              final List<TLToDo> updatedToDosInOtherList = [
                switchedToDo,
                ...currentWorkspaceRef.categoryIDToToDos[corrCategoryID]!
                    .getToDos(!ifInToday),
              ];

              final updatedCategoryIDToToDos = {
                ...currentWorkspaceRef.categoryIDToToDos,
                corrCategoryID: currentWorkspaceRef
                    .categoryIDToToDos[corrCategoryID]!
                    .copyWith(
                  toDosInToday: ifInToday
                      ? updatedToDosInCurrentList
                      : updatedToDosInOtherList,
                  toDosInWhenever: ifInToday
                      ? updatedToDosInOtherList
                      : updatedToDosInCurrentList,
                ),
              };

              // ワークスペースを更新
              tlAppStateReducer.dispatchWorkspaceAction(
                  TLWorkspaceAction.updateCurrentWorkspace(
                currentWorkspaceRef.copyWith(
                  categoryIDToToDos: updatedCategoryIDToToDos,
                ),
              ));

              TLVibrationService.vibrate();
              NotifyTodoOrStepIsEditedSnackBar.show(
                context: context,
                newTitle: corrTLToDo.title,
                newCheckedState: corrTLToDo.isChecked,
                quickChangeToToday: !ifInToday,
              );
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
