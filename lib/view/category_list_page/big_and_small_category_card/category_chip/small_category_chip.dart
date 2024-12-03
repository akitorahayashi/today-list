import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../component/dialog/for_category/select_edit_method_dialog.dart';
import '../../../../view_model/todo/tl_workspaces_state.dart';
import '../../../../model/tl_theme.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/workspace/tl_workspace.dart';

class SmallCategoryChip extends ConsumerWidget {
  final TLCategory corrBigCategory;
  final int corrIndexOfBigCategory;
  final int corrIndexOfSmallCategory;
  const SmallCategoryChip({
    super.key,
    required this.corrBigCategory,
    required this.corrIndexOfBigCategory,
    required this.corrIndexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace =
        ref.watch(tlWorkspacesStateProvider).currentWorkspace;
    // others
    final TLCategory smallCategoryOfThisCard = currentTLWorkspace
        .smallCategories[corrBigCategory.id]![corrIndexOfSmallCategory];
    // getNumberOfToDosInThisCategory
    final int numberOfToDoInThisSmallCategory =
        smallCategoryOfThisCard.getNumberOfToDosInThisCategory(
            ifInToday: null,
            corrToDos: currentTLWorkspace
                .categoryIDToToDos[smallCategoryOfThisCard.id]!);
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return SelectEditMethodDialog(
                categoryOfThisPage: smallCategoryOfThisCard,
                indexOfBigCategory: corrIndexOfBigCategory,
                indexOfSmallCategory: corrIndexOfSmallCategory,
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      smallCategoryOfThisCard.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: tlThemeData.accentColor),
                    ),
                  ),
                ),
              ),
              if (numberOfToDoInThisSmallCategory != 0)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Text(
                    "$numberOfToDoInThisSmallCategory",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: tlThemeData.accentColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
