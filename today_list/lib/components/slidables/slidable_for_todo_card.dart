import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import '../../model/workspace/current_tl_workspace_provider.dart';
import '../../model/workspace/tl_workspaces_provider.dart';
import '../../model/design/tl_theme.dart';
import '../../model/todo/tl_todo.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/workspace/tl_workspace.dart';

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
  final Function editAction;
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
    // workspace
    required this.editAction,
    required this.child,
  }) : _indexOfThisToDoInToDos = indexOfThisToDoInToDos;

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
    final String _corrCategoryID =
        smallCategoryOfThisToDo?.id ?? bigCategoryOfThisToDo.id;
    final List<TLToDo> _toDoArrayOfThisToDoBelongs =
        _currentTLWorkspace.toDos[_corrCategoryID]![ifInToday];
    return Slidable(
      // チェックされていたらスライドできなくする
      enabled: !corrTLToDo.isChecked,
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
            _toDoArrayOfThisToDoBelongs.removeAt(_indexOfThisToDoInToDos);
            TLVibration.vibrate();
            _tlWorkspacesNotifier.updateSpecificTLWorkspace(
                specificWorkspaceIndex: _currentTLWorkspaceIndex,
                updatedWorkspace: _currentTLWorkspace);
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
              backgroundColor: _tlThemeData.panelColor,
              foregroundColor: _tlThemeData.accentColor,
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
            backgroundColor: _tlThemeData.panelColor,
            foregroundColor: _tlThemeData.accentColor,
            onPressed: (BuildContext context) {
              // タップしたらtodayとwheneverを切り替える
              final TLToDo switchedToDo =
                  _toDoArrayOfThisToDoBelongs.removeAt(_indexOfThisToDoInToDos);
              _currentTLWorkspace.toDos[_corrCategoryID]![!ifInToday]
                  .insert(0, switchedToDo);
              TLVibration.vibrate();
              NotifyTodoOrStepIsEditedSnackBar.show(
                  context: context,
                  newTitle: corrTLToDo.title,
                  newCheckedState: corrTLToDo.isChecked,
                  quickChangeToToday: !ifInToday);
              _tlWorkspacesNotifier.updateSpecificTLWorkspace(
                  specificWorkspaceIndex: _currentTLWorkspaceIndex,
                  updatedWorkspace: _currentTLWorkspace);
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
