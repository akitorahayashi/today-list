import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/component/dialog/tl_base_dialog.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../model/provider/editing_provider/editing_category_provider.dart';
import '../../../model/provider/current_tl_workspace_provider.dart';
import '../../../model/external/tl_vibration.dart';
import '../../../model/provider/tl_workspaces_provider.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/design/tl_theme.dart';
import '../../../style/styles.dart';

class RenameCategoryDialog extends TLBaseConsumerStatefulDialog {
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
  late EditingCategoryNotifier editingCategoryNotifier;
  String enteredCategoryTitle = "";

  @override
  void initState() {
    super.initState();
    final currentWorkspace = ref.read(currentWorkspaceProvider);
    final TLCategory corrBigCategory =
        currentWorkspace.bigCategories[widget.indexOfBigCategory];
    final corrCategoryName = widget.indexOfSmallCategory == null
        ? corrBigCategory.title
        : currentWorkspace
            .smallCategories[corrBigCategory.id]![widget.indexOfSmallCategory!]
            .title;
    // notifier
    editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    EditingCategory.updateTextEditingController(
        editedCategoryTitle: corrCategoryName);
    enteredCategoryTitle = corrCategoryName;
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
    EditingCategory.categoryTitleInputController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final EditingCategory editingCategory = ref.watch(editingCategoryProvider);
    final currentWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    return AlertDialog(
      backgroundColor: tlThemeData.alertColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 18.0),
            child: SizedBox(
              width: 230,
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  editingCategory.selecteBigCategoryID == null
                      ? "なし"
                      : (() {
                          final hintArray = currentWorkspace.bigCategories
                              .where((bigCategory) =>
                                  bigCategory.id ==
                                  editingCategory.selecteBigCategoryID);
                          if (hintArray.isEmpty) {
                            editingCategory.selecteBigCategoryID = null;
                            return "なし";
                          } else {
                            return hintArray.first.title;
                          }
                        }()),
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.45),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: [
                  TLCategory(id: noneID, title: "なし"),
                  ...currentWorkspace.bigCategories.sublist(1),
                ].map((TLCategory bigCategory) {
                  return DropdownMenuItem(
                    value: bigCategory.id,
                    child: Text(
                      bigCategory.title,
                      style: bigCategory.id == noneID &&
                                  editingCategory.selecteBigCategoryID ==
                                      null ||
                              bigCategory.id ==
                                  editingCategory.selecteBigCategoryID
                          ? TextStyle(
                              color: tlThemeData.accentColor,
                              fontWeight: FontWeight.bold)
                          : TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (String? newBigCategoryId) async {
                  if (newBigCategoryId == noneID || newBigCategoryId == null) {
                    editingCategoryNotifier.updateEditingCategory(
                        selectedBigCatgoeyID: null);
                  } else {
                    editingCategoryNotifier.updateEditingCategory(
                        selectedBigCatgoeyID: newBigCategoryId);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
                width: 230,
                // 新しいカテゴリー名を入力するTextFormField
                child: TextField(
                  autofocus: true,
                  controller: EditingCategory.categoryTitleInputController,
                  onChanged: (s) {
                    setState(() {
                      enteredCategoryTitle = s;
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
                )),
          ),
          // 閉じる 追加するボタン
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              // カテゴリーを作らずにアラートを閉じるボタン
              TextButton(
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // カテゴリーを追加するボタン
              TextButton(
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  // 入力がなければ非活性
                  onPressed: enteredCategoryTitle.trim().isEmpty
                      ? null
                      : () async {
                          // カテゴリー名が入力されているなら追加する
                          await editingCategoryNotifier.completeEditing();
                          TLVibration.vibrate();
                          // to category list
                          if (context.mounted) {
                            Navigator.pop(context);
                            const TLSingleOptionDialog(
                                    title: "カテゴリーが\n変更されました！")
                                .show(context: context);
                          }
                        },
                  child: const Text("追加"))
            ],
          )
        ],
      ),
    );
  }
}
