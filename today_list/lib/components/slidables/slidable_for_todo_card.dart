import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../model/provider/current_tl_workspace_provider.dart';
import '../../model/provider/tl_workspaces_provider.dart';
import '../../model/design/tl_theme.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/tl_workspace.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableForToDoCard extends ConsumerWidget {
  final bool isForModelCard;
  // todo
  final TLToDo corrTLToDo;
  final int _indexOfThisToDoInToDos;
  final bool ifInToday;
  // category
  final TLCategory bigCategoryOfThisToDo;
  final TLCategory? smallCategoryOfThisToDo;
  // child
  final Widget child;
  const SlidableForToDoCard({
    super.key,
    required this.isForModelCard,
    required this.corrTLToDo,
    required int indexOfThisToDoInToDos,
    required this.ifInToday,
    // category
    required this.bigCategoryOfThisToDo,
    required this.smallCategoryOfThisToDo,
    // child
    required this.child,
  }) : _indexOfThisToDoInToDos = indexOfThisToDoInToDos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    // other
    final int currentTLWorkspaceIndex =
        currentTLWorkspaceNotifier.currentTLWorkspaceIndex;
    final String corrCategoryID =
        smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id;
    final List<TLToDo> toDoArrayOfThisToDoBelongs =
        currentTLWorkspace.toDos[corrCategoryID]![ifInToday];
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
            toDoArrayOfThisToDoBelongs.removeAt(_indexOfThisToDoInToDos);
            TLVibration.vibrate();
            tlWorkspacesNotifier.updateSpecificTLWorkspace(
                specificWorkspaceIndex: currentTLWorkspaceIndex,
                updatedWorkspace: currentTLWorkspace);
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
              // TODO 編集画面に遷移
              onPressed: (BuildContext context) async {},
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
                  toDoArrayOfThisToDoBelongs.removeAt(_indexOfThisToDoInToDos);
              currentTLWorkspace.toDos[corrCategoryID]![!ifInToday]
                  .insert(0, switchedToDo);
              TLVibration.vibrate();
              NotifyTodoOrStepIsEditedSnackBar.show(
                  context: context,
                  newTitle: corrTLToDo.title,
                  newCheckedState: corrTLToDo.isChecked,
                  quickChangeToToday: !ifInToday);
              tlWorkspacesNotifier.updateSpecificTLWorkspace(
                  specificWorkspaceIndex: currentTLWorkspaceIndex,
                  updatedWorkspace: currentTLWorkspace);
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
