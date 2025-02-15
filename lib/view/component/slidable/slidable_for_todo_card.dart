import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/view/screen/edit_todo_page/edit_todo_page.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';

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
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref.watch(
      tlAppStateProvider.select((state) => state.getCurrentWorkspace),
    );

    final String corrCategoryID = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArray =
        currentWorkspace.categoryIDToToDos[corrCategoryID]!.getToDos(ifInToday);

    // MARK: - Colors
    final backgroundColor = tlThemeData.canTapCardColor;
    final foregroundColor = tlThemeData.accentColor;

    return Slidable(
      enabled: !corrTLToDo.isChecked,

      // MARK: - Delete ToDo
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.15,
        children: [
          SlidableAction(
            autoClose: true,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            onPressed: (context) => _handleDeleteToDo(
                ref, currentWorkspace, toDoArray, corrCategoryID),
            icon: Icons.remove,
          ),
        ],
      ),

      // MARK: - Edit / Move ToDo
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.4,
        children: [
          // MARK: - Edit ToDo
          if (!isForModelCard)
            SlidableAction(
              autoClose: true,
              flex: 10,
              spacing: 8,
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              onPressed: (context) => _handleEditToDo(context, toDoArray),
              icon: Icons.edit,
            ),

          // MARK: - Toggle Between Today and Whenever
          SlidableAction(
            autoClose: true,
            flex: 11,
            spacing: 8,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            onPressed: (context) => _toggleToDoTodayWhenever(
                ref, context, currentWorkspace, toDoArray, corrCategoryID),
            icon: ifInToday ? Icons.schedule : Icons.light_mode,
          ),
        ],
      ),
      child: child,
    );
  }

  // MARK: - Handle Delete ToDo
  void _handleDeleteToDo(WidgetRef ref, TLWorkspace currentWorkspace,
      List<TLToDo> toDoArray, String corrCategoryID) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    // Remove the ToDo from the list
    final List<TLToDo> updatedToDos = List.from(toDoArray)
      ..removeAt(indexOfThisToDoInToDos);

    // Update the workspace state
    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      corrCategoryID: currentWorkspace.categoryIDToToDos[corrCategoryID]!
          .copyWith(toDosInToday: updatedToDos),
    };

    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCurrentWorkspace(
        currentWorkspace.copyWith(categoryIDToToDos: updatedCategoryIDToToDos),
      ),
    );

    TLVibrationService.vibrate();
  }

  // MARK: - Handle Edit ToDo
  void _handleEditToDo(BuildContext context, List<TLToDo> toDoArray) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EditToDoPage(
            ifInToday: true,
            selectedBigCategoryID: bigCategoryID,
            selectedSmallCategoryID: smallCategoryID,
            editedToDoTitle: toDoArray[indexOfThisToDoInToDos].content,
            indexOfEdittedTodo: indexOfThisToDoInToDos,
          );
        },
      ),
    );
  }

  // MARK: - Toggle ToDo Between Today and Whenever
  void _toggleToDoTodayWhenever(
      WidgetRef ref,
      BuildContext context,
      TLWorkspace currentWorkspace,
      List<TLToDo> toDoArray,
      String corrCategoryID) {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);
    final TLToDo switchedToDo = toDoArray[indexOfThisToDoInToDos];

    // Separate ToDos based on switch
    final List<TLToDo> updatedToDosInCurrentList = List.from(toDoArray)
      ..removeAt(indexOfThisToDoInToDos);
    final List<TLToDo> updatedToDosInOtherList = [
      switchedToDo,
      ...currentWorkspace.categoryIDToToDos[corrCategoryID]!
          .getToDos(!ifInToday),
    ];

    final updatedCategoryIDToToDos = {
      ...currentWorkspace.categoryIDToToDos,
      corrCategoryID:
          currentWorkspace.categoryIDToToDos[corrCategoryID]!.copyWith(
        toDosInToday:
            ifInToday ? updatedToDosInCurrentList : updatedToDosInOtherList,
        toDosInWhenever:
            ifInToday ? updatedToDosInOtherList : updatedToDosInCurrentList,
      ),
    };

    // Update workspace state
    tlAppStateReducer.dispatchWorkspaceAction(
      TLWorkspaceAction.updateCurrentWorkspace(
        currentWorkspace.copyWith(categoryIDToToDos: updatedCategoryIDToToDos),
      ),
    );

    TLVibrationService.vibrate();
    NotifyTodoOrStepIsEditedSnackBar.show(
      context: context,
      newTitle: corrTLToDo.content,
      newCheckedState: corrTLToDo.isChecked,
      quickChangeToToday: !ifInToday,
    );
  }
}
