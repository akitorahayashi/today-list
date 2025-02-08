import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_category_utils.dart';
import 'package:today_list/view/component/dialog/for_category/select_edit_method_dialog.dart';

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
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspace = ref.watch(tlAppStateProvider
        .select((state) => state.tlWorkspaces[state.currentWorkspaceIndex]));

    final smallCategory = _getSmallCategory(currentWorkspace);
    final numberOfToDos = _getNumberOfToDos(currentWorkspace, smallCategory);

    return GestureDetector(
      onTap: () => _showEditDialog(context, smallCategory),
      child:
          _buildSmallCategoryChipUI(tlThemeData, smallCategory, numberOfToDos),
    );
  }

  // MARK - Get Small Category Data
  TLCategory _getSmallCategory(TLWorkspace currentWorkspace) {
    return currentWorkspace
        .smallCategories[corrBigCategory.id]![corrIndexOfSmallCategory];
  }

  // MARK - Get Number of ToDos
  int _getNumberOfToDos(
      TLWorkspace currentWorkspace, TLCategory smallCategory) {
    return TLCategoryUtils.getNumberOfToDosInThisCategory(
      ifInToday: null,
      corrToDos: currentWorkspace.categoryIDToToDos[smallCategory.id]!,
    );
  }

  // MARK - Show Edit Dialog
  Future<void> _showEditDialog(
      BuildContext context, TLCategory smallCategory) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SelectEditMethodDialog(
          categoryOfThisPage: smallCategory,
          indexOfBigCategory: corrIndexOfBigCategory,
          indexOfSmallCategory: corrIndexOfSmallCategory,
        );
      },
    );
  }

  // MARK - Build Small Category Chip UI
  Widget _buildSmallCategoryChipUI(
      TLThemeConfig tlThemeData, TLCategory smallCategory, int numberOfToDos) {
    return Card(
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
                    smallCategory.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 15,
                      color: tlThemeData.accentColor,
                    ),
                  ),
                ),
              ),
            ),
            if (numberOfToDos != 0)
              Padding(
                padding: const EdgeInsets.only(right: 24.0),
                child: Text(
                  "$numberOfToDos",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: tlThemeData.accentColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
