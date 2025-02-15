import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_category_utils.dart';
import '../../../../component/dialog/for_category/select_edit_method_dialog.dart';
import '../../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../../model/todo/tl_todo_category.dart';
import '../../../../../model/todo/tl_workspace.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigCategoryChip extends ConsumerWidget {
  final int indexOfBigCategory;

  const BigCategoryChip({super.key, required this.indexOfBigCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final currentWorkspaceRef = ref
        .watch(tlAppStateProvider.select((state) => state.getCurrentWorkspace));

    final bigCategory = _getBigCategory(currentWorkspaceRef);
    final numberOfToDos = _getNumberOfToDos(currentWorkspaceRef, bigCategory);

    return _buildChipUI(context, currentWorkspaceRef.id, tlThemeData,
        bigCategory, numberOfToDos);
  }

  // MARK - Get Big Category Data
  TLToDoCategory _getBigCategory(TLWorkspace currentWorkspace) {
    return currentWorkspace.bigCategories[indexOfBigCategory];
  }

  // MARK - Get Number of ToDos
  int _getNumberOfToDos(
      TLWorkspace currentWorkspace, TLToDoCategory bigCategory) {
    return TLCategoryUtils.getNumberOfToDosInThisCategory(
      ifInToday: null,
      corrToDos: currentWorkspace.categoryIDToToDos[bigCategory.id]!,
    );
  }

  // MARK - Show Edit Dialog
  Future<void> _showEditDialog(BuildContext context, String workspaceID,
      TLToDoCategory bigCategory) async {
    await showDialog(
      context: context,
      builder: (context) {
        return SelectEditMethodDialog(
          corrWorkspaceID: workspaceID,
          categoryOfThisPage: bigCategory,
        );
      },
    );
  }

  // MARK - Build Chip UI
  Widget _buildChipUI(
      BuildContext context,
      String workspaceID,
      TLThemeConfig tlThemeData,
      TLToDoCategory bigCategory,
      int numberOfToDos) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        height: 80,
        child: InputChip(
          backgroundColor: tlThemeData.bigCategoryChipColor,
          avatar: const Icon(FontAwesomeIcons.rectangleList),
          label: SizedBox(
            height: 35,
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(bigCategory.title),
                  ),
                ),
                if (numberOfToDos != 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("$numberOfToDos"),
                  ),
              ],
            ),
          ),
          labelStyle: const TextStyle(
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
          pressElevation: 3,
          elevation: 3,
          onPressed: () => _showEditDialog(context, workspaceID, bigCategory),
        ),
      ),
    );
  }
}
