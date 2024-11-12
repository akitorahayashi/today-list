import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/model/provider/editing_provider/editing_category_provider.dart';
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
  late EditingCategoryNotifier edittingCategoryNotifier;
  String _enteredCategoryTitle = "";

  @override
  void initState() {
    super.initState();
    final currentWorkspace = ref.read(currentWorkspaceProvider);
    final corrCategoryName = widget.indexOfSmallCategory == null
        ? currentWorkspace.bigCategories[widget.indexOfBigCategory].title
        : currentWorkspace
            .smallCategories[currentWorkspace
                .bigCategories[widget.indexOfBigCategory]
                .id]![widget.indexOfSmallCategory!]
            .title;
    // notifier
    edittingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    EditingCategory.updateTextEditingController(
        editedCategoryTitle: corrCategoryName);
    Future.microtask(() {
      // stateのbigCategoryIDはsetEditedCategoryで設定
      ref.read(editingCategoryProvider.notifier).setEditedCategory(
            indexOfEditingBigCategory: widget.indexOfBigCategory,
            indexOfEditingSmallCategory: widget.indexOfSmallCategory,
          );
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      edittingCategoryNotifier.disposeValue();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final currentWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final edittingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
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
                    controller: EditingCategory.categoryTitleInputController,
                    onChanged: (s) {
                      setState(() {
                        _enteredCategoryTitle = s;
                      });
                    },
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
                    onPressed: _enteredCategoryTitle.trim().trim().isEmpty
                        ? null
                        : () {
                            edittingCategoryNotifier.completeEditting();
                            TLVibration.vibrate();
                            // to category list
                            Navigator.pop(context, null);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const TLSingleOptionDialog(
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
