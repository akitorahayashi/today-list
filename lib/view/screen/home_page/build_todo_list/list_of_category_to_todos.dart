import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'todos_in_category/header_for_todos.dart';
import 'todos_in_category/todos_in_category.dart';

class ListOfCategoryToToDos extends ConsumerWidget {
  final bool ifInToday;
  final TLWorkspace currentWorkspace;
  const ListOfCategoryToToDos({
    super.key,
    required this.ifInToday,
    required this.currentWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWorkspace = ref.watch(tlAppStateProvider
        .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]));
    return Column(
      children: [
        if (currentWorkspace
            .categoryIDToToDos[currentWorkspace.bigCategories[0].id]!
            .getToDos(ifInToday)
            .isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ToDosInCategory(
              ifInToday: ifInToday,
              bigCategoryOfThisToDo: currentWorkspace.bigCategories[0],
              smallCategoryOfThisToDo: null,
            ),
          ),
        // なし以外のbigCategoryの処理
        for (TLCategory bigCategory
            in currentWorkspace.bigCategories.sublist(1))
          Column(
            children: [
              // big header
              if (currentWorkspace.categoryIDToToDos[bigCategory.id]!
                      .getToDos(ifInToday)
                      .isNotEmpty ||
                  // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                  (currentWorkspace
                          .smallCategories[bigCategory.id]!.isNotEmpty &&
                      currentWorkspace.smallCategories[bigCategory.id]!
                              .indexWhere((smallCategory) => currentWorkspace
                                  .categoryIDToToDos[smallCategory.id]!
                                  .getToDos(ifInToday)
                                  .isNotEmpty) !=
                          -1))
                CategoryHeaderForToDos(
                    isBigCategory: true, corrCategory: bigCategory),
              // big body
              if (currentWorkspace.categoryIDToToDos[bigCategory.id]!
                  .getToDos(ifInToday)
                  .isNotEmpty)
                ToDosInCategory(
                  ifInToday: ifInToday,
                  bigCategoryOfThisToDo: bigCategory,
                  smallCategoryOfThisToDo: null,
                ),
              for (TLCategory smallCategory
                  in currentWorkspace.smallCategories[bigCategory.id] ?? [])
                if (currentWorkspace.categoryIDToToDos[smallCategory.id]!
                    .getToDos(ifInToday)
                    .isNotEmpty)
                  Column(
                    children: [
                      // small header
                      CategoryHeaderForToDos(
                          isBigCategory: false, corrCategory: smallCategory),
                      // small body
                      ToDosInCategory(
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
