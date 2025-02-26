import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'model_of_todo_card.dart';

class AlreadyExist extends StatelessWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;
  final String bigCategoryID;
  final String? smallCategoryID;

  const AlreadyExist({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
    required this.bigCategoryID,
    required this.smallCategoryID,
  });

  @override
  Widget build(BuildContext context) {
    final tlThemeConfig = TLTheme.of(context);
    final String categoryOfThisToDo = smallCategoryID ?? bigCategoryID;
    final List<TLToDo> toDoArrayOfThisBlock = corrWorkspace
            .categoryIDToToDos[categoryOfThisToDo]
            ?.getToDos(ifInToday) ??
        [];

    // `toDoArrayOfThisBlock` が空の場合は何も表示しない
    if (toDoArrayOfThisBlock.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Card(
        color: tlThemeConfig.whiteBasedColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeInOutCubic,
                  ),
                  child: child,
                ),
              );
            },
            child: Column(
              key: ValueKey(toDoArrayOfThisBlock.length),
              children: [
                for (int indexOfThisToDoInToDos = 0;
                    indexOfThisToDoInToDos < toDoArrayOfThisBlock.length;
                    indexOfThisToDoInToDos++)
                  ModelOfToDoCard(
                    key: ValueKey(
                        toDoArrayOfThisBlock[indexOfThisToDoInToDos].id),
                    corrWorkspace: corrWorkspace,
                    ifInToday: ifInToday,
                    corrTLToDo: toDoArrayOfThisBlock[indexOfThisToDoInToDos],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
