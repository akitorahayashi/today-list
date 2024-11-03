import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/model/workspace/current_tl_workspace_provider.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/workspace/tl_workspace.dart';

class SmallCategoryCard extends ConsumerWidget {
  final String corrBigCategoryID;
  final int corrIndexOfSmallCategory;
  const SmallCategoryCard({
    super.key,
    required this.corrBigCategoryID,
    required this.corrIndexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    // provider
    final TLWorkspace _currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    // others
    final TLCategory _smallCategoryOfThisCard = _currentTLWorkspace
        .smallCategories[corrBigCategoryID]![corrIndexOfSmallCategory];
    // getNumberOfToDosInThisCategory
    final int _numberOfToDoInThisSmallCategory = (() {
      TLToDos _coorToDos =
          _currentTLWorkspace.toDos[_smallCategoryOfThisCard.id]!;
      final int _answer = _coorToDos[true].length + _coorToDos[false].length;
      return _answer;
    })();
    return GestureDetector(
      // TODO カテゴリーを編集するDialogを表示
      onTap: () {},
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
                      _smallCategoryOfThisCard.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          color: _tlThemeData.accentColor),
                    ),
                  ),
                ),
              ),
              if (_numberOfToDoInThisSmallCategory != 0)
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: Text(
                    "$_numberOfToDoInThisSmallCategory",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: _tlThemeData.accentColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
