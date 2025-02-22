import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'todos_in_category/header_for_todos.dart';
import 'todos_in_category/todos_in_category.dart';

class ListOfCategoryToToDos extends ConsumerWidget {
  final bool ifInToday;

  const ListOfCategoryToToDos({
    super.key,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWorkspace =
        ref.watch(tlAppStateProvider.select((state) => state.getCorrWorkspace));

    return Column(
      children: [
        _DefaultCategory(
            currentWorkspace: currentWorkspace, ifInToday: ifInToday),
        for (TLToDoCategory bigCategory
            in currentWorkspace.bigCategories.sublist(1))
          _BigCategorySection(
            currentWorkspace: currentWorkspace,
            bigCategory: bigCategory,
            ifInToday: ifInToday,
          ),
      ],
    );
  }
}

// MARK - Default Category Section (bigCategories[0])
class _DefaultCategory extends StatelessWidget {
  final TLWorkspace currentWorkspace;
  final bool ifInToday;

  const _DefaultCategory({
    required this.currentWorkspace,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    // ビッグカテゴリの最初の要素に ToDo がある場合のみ表示
    if (currentWorkspace
        .categoryIDToToDos[currentWorkspace.bigCategories[0].id]!
        .getToDos(ifInToday)
        .isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ToDosInCategory(
        ifInToday: ifInToday,
        bigCategoryOfThisToDo: currentWorkspace.bigCategories[0],
        smallCategoryOfThisToDo: null,
      ),
    );
  }
}

// MARK - Big Category Section
class _BigCategorySection extends StatelessWidget {
  final TLWorkspace currentWorkspace;
  final TLToDoCategory bigCategory;
  final bool ifInToday;

  const _BigCategorySection({
    required this.currentWorkspace,
    required this.bigCategory,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_shouldShowBigCategoryHeader(currentWorkspace, bigCategory))
          CategoryHeaderForToDos(
              isBigCategory: true, corrCategory: bigCategory),
        if (currentWorkspace.categoryIDToToDos[bigCategory.id]!
            .getToDos(ifInToday)
            .isNotEmpty)
          ToDosInCategory(
            ifInToday: ifInToday,
            bigCategoryOfThisToDo: bigCategory,
            smallCategoryOfThisToDo: null,
          ),
        for (TLToDoCategory smallCategory
            in currentWorkspace.smallCategories[bigCategory.id] ?? [])
          _SmallCategorySection(
            currentWorkspace: currentWorkspace,
            bigCategory: bigCategory,
            smallCategory: smallCategory,
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
  final TLWorkspace currentWorkspace;
  final TLToDoCategory bigCategory;
  final TLToDoCategory smallCategory;
  final bool ifInToday;

  const _SmallCategorySection({
    required this.currentWorkspace,
    required this.bigCategory,
    required this.smallCategory,
    required this.ifInToday,
  });

  @override
  Widget build(BuildContext context) {
    // スモールカテゴリに ToDo がある場合のみ表示
    if (currentWorkspace.categoryIDToToDos[smallCategory.id]!
        .getToDos(ifInToday)
        .isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        CategoryHeaderForToDos(
            isBigCategory: false, corrCategory: smallCategory),
        ToDosInCategory(
          ifInToday: ifInToday,
          bigCategoryOfThisToDo: bigCategory,
          smallCategoryOfThisToDo: smallCategory,
        ),
      ],
    );
  }
}
