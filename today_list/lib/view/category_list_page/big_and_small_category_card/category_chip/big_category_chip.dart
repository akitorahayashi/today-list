import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/for_category/select_edit_method_dialog.dart';
import '../../../../model/provider/current_tl_workspace_provider.dart';
import '../../../../model/design/tl_theme.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/tl_workspace.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BigCategoryChip extends ConsumerWidget {
  final int indexOfBigCategory;
  const BigCategoryChip({super.key, required this.indexOfBigCategory});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace currentTLWorkspace = ref.watch(currentWorkspaceProvider);
    // others
    TLCategory bigCategoryOfThisChip =
        currentTLWorkspace.bigCategories[indexOfBigCategory];
    final int numberOfToDosInThisCategory =
        bigCategoryOfThisChip.getNumberOfToDosInThisCategory(
            ifInToday: null,
            corrToDos: currentTLWorkspace
                .categoryIDToToDos[bigCategoryOfThisChip.id]!);
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
                    child: Text(
                      bigCategoryOfThisChip.title,
                    ),
                  ),
                ),
                if (numberOfToDosInThisCategory != 0)
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("$numberOfToDosInThisCategory"),
                  )
              ],
            ),
          ),
          labelStyle: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: Colors.white),
          pressElevation: 3,
          elevation: 3,
          onPressed: () => {
            showDialog(
                context: context,
                builder: (context) {
                  return SelectEditMethodDialog(
                    categoryOfThisPage: bigCategoryOfThisChip,
                    indexOfBigCategory: indexOfBigCategory,
                    indexOfSmallCategory: null,
                  );
                })
          },
        ),
      ),
    );
  }
}
