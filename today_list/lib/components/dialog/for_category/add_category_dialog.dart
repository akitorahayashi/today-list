import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/styles/styles.dart';
import '../../../model/provider/editing_provider/editing_category_provider.dart';

class AddCategoryDialog extends ConsumerStatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  late EditingCategoryNotifier editingCategoryNotifier;
  String enteredCategoryTitle = "";
  @override
  void initState() {
    super.initState();
    editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    EditingCategory.updateTextEditingController(editedCategoryTitle: null);
    Future.microtask(() {
      editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
      editingCategoryNotifier.setInitialValue();
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
                          await editingCategoryNotifier.completeEditting();
                          TLVibration.vibrate();
                          // to category list
                          if (context.mounted) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return const TLSingleOptionDialog(
                                      title: "カテゴリーが\n追加されました！", message: null);
                                });
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
