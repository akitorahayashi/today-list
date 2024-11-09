import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/single_option_dialog.dart';
import 'package:today_list/model/editting_provider/editting_category_provider.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/styles/styles.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/design/tl_theme.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';

class RenameCategoryDialog extends ConsumerStatefulWidget {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;
  const RenameCategoryDialog({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  ConsumerState<RenameCategoryDialog> createState() =>
      _RenameCategoryDialogState();
}

class _RenameCategoryDialogState extends ConsumerState<RenameCategoryDialog> {
  @override
  void initState() {
    super.initState();
    // stateのbigCategoryIDはsetEditedCategoryで設定
    ref.read(edittingCategoryProvider.notifier).setEditedCategory(
          indexOfEditingBigCategory: widget.indexOfBigCategory,
          indexOfEditingSmallCategory: widget.indexOfSmallCategory,
        );
  }

  @override
  void dispose() {
    ref.read(edittingCategoryProvider.notifier).disposeValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final currentWorkspace = ref.watch(currentWorkspaceProvider);
    final EdittingCategory edittingCategory =
        ref.watch(edittingCategoryProvider);
    // notifier
    final edittingCategoryNotifier =
        ref.read(edittingCategoryProvider.notifier);
    // other
    final corrBigCategory =
        currentWorkspace.bigCategories[widget.indexOfBigCategory];
    final TLCategory oldCategory = widget.indexOfSmallCategory == null
        ? corrBigCategory
        : currentWorkspace
            .smallCategories[corrBigCategory.id]![widget.indexOfSmallCategory!];
    return AlertDialog(
      backgroundColor: tlThemeData.alertColor,
      title: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3.0),
            child: Text("元のカテゴリー名",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black.withOpacity(0.5),
                    fontWeight: FontWeight.w600)),
          ),
          Text(
            oldCategory.title,
            style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.w600),
          )
        ],
      ),
      content: SizedBox(
        height: 160,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 新しいカテゴリー名を入力するTextFormField
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  width: 230,
                  child: TextFormField(
                    autofocus: true,
                    controller: edittingCategory.categoryTitleInputController,
                    cursorColor: tlThemeData.accentColor,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w600),
                    decoration: tlInputDecoration(
                        context: context,
                        labelText: "新しいカテゴリー名",
                        icon: null,
                        suffixIcon: null),
                  ),
                ),
              ),
              // 戻す、完了ボタン
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 戻すボタン
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "戻る",
                      style: TextStyle(color: tlThemeData.accentColor),
                    ),
                  ),
                  // 完了ボタン
                  TextButton(
                    onPressed: (edittingCategory
                                .categoryTitleInputController?.text
                                .trim()
                                .isEmpty ??
                            true)
                        ? null
                        : () {
                            edittingCategoryNotifier.completeEditting();
                            TLVibration.vibrate();
                            // to category list
                            Navigator.pop(context, null);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SingleOptionDialog(
                                      title: "変更することに\n成功しました!", message: null);
                                });
                          },
                    child: Text(
                      "完了",
                      style: TextStyle(color: tlThemeData.accentColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
