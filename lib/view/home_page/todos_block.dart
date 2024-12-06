import 'package:flutter/material.dart';
import './todos_in_this_category_today/header_for_todos.dart';
import './todos_in_this_category_today/todos_in_this_category_in_today.dart';
import '../../model/todo/tl_category.dart';
import '../../model/todo/tl_workspace.dart';

class TodosBlock extends StatelessWidget {
  final bool ifInToday;
  final TLWorkspace currentTLWorkspace;
  const TodosBlock({
    super.key,
    required this.ifInToday,
    required this.currentTLWorkspace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ここにウィジェットを追加
        if (currentTLWorkspace
            .categoryIDToToDos[currentTLWorkspace.bigCategories[0].id]![
                ifInToday]
            .isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ToDosInThisCategoryInCurrentWorkspace(
              ifInToday: ifInToday,
              bigCategoryOfThisToDo: currentTLWorkspace.bigCategories[0],
              smallCategoryOfThisToDo: null,
            ),
          ),
        // なし以外のbigCategoryの処理
        for (TLCategory bigCategory
            in currentTLWorkspace.bigCategories.sublist(1))
          Column(
            children: [
              // big header
              if (currentTLWorkspace
                      .categoryIDToToDos[bigCategory.id]![ifInToday]
                      .isNotEmpty ||
                  // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                  (currentTLWorkspace
                          .smallCategories[bigCategory.id]!.isNotEmpty &&
                      currentTLWorkspace.smallCategories[bigCategory.id]!
                              .indexWhere((smallCategory) => currentTLWorkspace
                                  .categoryIDToToDos[smallCategory.id]![
                                      ifInToday]
                                  .isNotEmpty) !=
                          -1))
                CategoryHeaderForToDos(
                    isBigCategory: true, corrCategory: bigCategory),
              // big body
              if (currentTLWorkspace
                  .categoryIDToToDos[bigCategory.id]![ifInToday].isNotEmpty)
                ToDosInThisCategoryInCurrentWorkspace(
                  ifInToday: ifInToday,
                  bigCategoryOfThisToDo: bigCategory,
                  smallCategoryOfThisToDo: null,
                ),
              for (TLCategory smallCategory
                  in currentTLWorkspace.smallCategories[bigCategory.id] ?? [])
                if (currentTLWorkspace
                    .categoryIDToToDos[smallCategory.id]![ifInToday].isNotEmpty)
                  Column(
                    children: [
                      // small header
                      CategoryHeaderForToDos(
                          isBigCategory: false, corrCategory: smallCategory),
                      // small body
                      ToDosInThisCategoryInCurrentWorkspace(
                        ifInToday: ifInToday,
                        bigCategoryOfThisToDo: bigCategory,
                        smallCategoryOfThisToDo: smallCategory,
                      )
                    ],
                  ),
            ],
          )
      ],
    );
  }
}
