import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/view/component/slidable/slidable_for_todo_card.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'tl_checkbox.dart';
import 'tl_step_card.dart';
import 'dart:ui';

import 'package:reorderables/reorderables.dart';

class TLToDoCard extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final TLToDo corrToDo;

  const TLToDoCard({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.corrToDo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - Colors
    final panelColor = tlThemeData.canTapCardColor;
    final textColor = Colors.black.withOpacity(corrToDo.isChecked ? 0.3 : 0.6);

    return GestureDetector(
      onTap: () {
        // スナックバーを表示
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: corrToDo.content,
          newCheckedState: !corrToDo.isChecked,
          isToDoCard: true,
          quickChangeToToday: null,
        );
        ref.read(tlAppStateProvider.notifier).updateState(
            TLToDoAction.toggleToDoCheckStatus(
                corrWorkspace: corrWorkspace, corrToDo: corrToDo));
      },
      onLongPress: corrToDo.isChecked ? () {} : null,
      child: Card(
        color: panelColor,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SlidableForToDoCard(
              corrWorkspace: corrWorkspace,
              corrToDo: corrToDo,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _BuildToDoContent(
                    textColor: textColor,
                    corrToDo: corrToDo,
                  ),
                  if (corrToDo.steps.isNotEmpty)
                    _BuildStepsList(
                      corrToDo: corrToDo,
                      corrWorkspace: corrWorkspace,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildToDoContent extends StatelessWidget {
  final Color textColor;
  final TLToDo corrToDo;
  const _BuildToDoContent({
    required this.textColor,
    required this.corrToDo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(16, 18, 16, corrToDo.steps.isNotEmpty ? 15 : 18),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 16, 0),
            child: Transform.scale(
              scale: 1.2,
              child: TLCheckBox(isChecked: corrToDo.isChecked),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                corrToDo.content,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// MARK: - Steps List
class _BuildStepsList extends ConsumerWidget {
  final TLToDo corrToDo;
  final TLWorkspace corrWorkspace;

  const _BuildStepsList({
    required this.corrToDo,
    required this.corrWorkspace,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ReorderableColumn(
          children: List.generate(
            corrToDo.steps.length,
            (int index) => Padding(
              key: ValueKey(corrToDo.steps[index].id),
              padding: const EdgeInsets.fromLTRB(8, 0, 2, 0),
              child: TLStepCard(
                ifInToday: corrToDo.isInToday,
                corrWorkspace: corrWorkspace,
                corrToDo: corrToDo,
                corrStep: corrToDo.steps[index],
              ),
            ),
          ),
          onReorder: (oldIndex, newIndex) => ref
              .read(tlAppStateProvider.notifier)
              .updateState(TLToDoAction.reorderSteps(
                  corrWorkspace: corrWorkspace,
                  corrToDo: corrToDo,
                  oldIndex: oldIndex,
                  newIndex: newIndex))),
    );
  }
}
