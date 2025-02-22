import 'package:flutter/material.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'todos_in_category/header_for_todos.dart';
import 'todos_in_category/todos_in_category.dart';

class ListOfCategoryToToDos extends StatelessWidget {
  final bool ifInToday;
  final TLWorkspace corrWorkspace;

  const ListOfCategoryToToDos({
    super.key,
    required this.ifInToday,
    required this.corrWorkspace,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DefaultCategory(corrWorkspace: corrWorkspace, ifInToday: ifInToday),
        for (TLToDoCategory bigCategory
            in corrWorkspace.bigCategories.sublist(1))
          _BigCategorySection(
            corrWorkspace: corrWorkspace,
            corrBigCategory: bigCategory,
            ifInToday: ifInToday,
          ),
      ],
    );
  }
}

// MARK - Default Category Section (bigCategories[0])
class _DefaultCategory extends StatelessWidget {
  final TLWorkspace corrWorkspace;
  final bool ifInToday;

  const _DefaultCategory({
    required this.corrWorkspace,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    // ビッグカテゴリの最初の要素に ToDo がある場合のみ表示
    if (corrWorkspace.categoryIDToToDos[corrWorkspace.bigCategories[0].id]!
        .getToDos(ifInToday)
        .isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ToDosInCategory(
        corrWorkspace: corrWorkspace,
        ifInToday: ifInToday,
        categoryID: noneID,
        isBigCategory: true,
      ),
    );
  }
}

// MARK - Big Category Section
class _BigCategorySection extends StatelessWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory corrBigCategory;
  final bool ifInToday;

  const _BigCategorySection({
    required this.corrWorkspace,
    required this.corrBigCategory,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_shouldShowBigCategoryHeader(corrWorkspace, corrBigCategory))
          CategoryHeaderForToDos(
              isBigCategory: true, corrCategory: corrBigCategory),
        if (corrWorkspace.categoryIDToToDos[corrBigCategory.id]!
            .getToDos(ifInToday)
            .isNotEmpty)
          ToDosInCategory(
            ifInToday: ifInToday,
            corrWorkspace: corrWorkspace,
            categoryID: corrBigCategory.id,
            isBigCategory: true,
          ),

        // _SmallCategorySection
        for (TLToDoCategory smallCategory
            in corrWorkspace.smallCategories[corrBigCategory.id] ?? [])
          _SmallCategorySection(
            corrWorkspace: corrWorkspace,
            corrSmallCategory: smallCategory,
            ifInToday: ifInToday,
          ),
      ],
    );
  }

  // MARK - Determine if Big Category Header Should Be Displayed
  bool _shouldShowBigCategoryHeader(
      TLWorkspace currentWorkspace, TLToDoCategory bigCategory) {
    return
        // ① ビッグカテゴリ自体に ToDo が 1 つでもある場合、ヘッダーを表示する
        currentWorkspace.categoryIDToToDos[bigCategory.id]!
                .getToDos(ifInToday)
                .isNotEmpty ||
            (
                // ② ビッグカテゴリに属するスモールカテゴリのいずれかに ToDo がある場合も、ヘッダーを表示する
                currentWorkspace.smallCategories[bigCategory.id]!.isNotEmpty &&
                    currentWorkspace.smallCategories[bigCategory.id]!
                            .indexWhere((smallCategory) => currentWorkspace
                                .categoryIDToToDos[smallCategory.id]!
                                .getToDos(ifInToday)
                                .isNotEmpty) !=
                        -1);
  }
}

// MARK - Small Category Section
class _SmallCategorySection extends StatelessWidget {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory corrSmallCategory;
  final bool ifInToday;

  const _SmallCategorySection({
    required this.corrWorkspace,
    required this.corrSmallCategory,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    // スモールカテゴリに ToDo がある場合のみ表示
    if (corrWorkspace.categoryIDToToDos[corrSmallCategory.id]!
        .getToDos(ifInToday)
        .isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CategoryHeaderForToDos(
            isBigCategory: false, corrCategory: corrSmallCategory),
        ToDosInCategory(
          ifInToday: ifInToday,
          corrWorkspace: corrWorkspace,
          categoryID: corrSmallCategory.id,
          isBigCategory: false,
        ),
      ],
    );
  }
}
