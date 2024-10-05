import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/todo/tl_todos.dart';
import '../../../model/tl_category.dart';
import '../../../model/workspace/tl_workspace.dart';
import '../../../model/workspace/tl_workspaces.dart';
import '../../../model/user/setting_data.dart';
import '../../../constants/global_keys.dart';
import '../../../crud/for_todo_category/add_todo_category_alert.dart';
import '../../../crud/for_todo_category/notify_category_is_added.dart';
import '../../../styles.dart';

class AddCategorySheet extends StatefulWidget {
  const AddCategorySheet({
    super.key,
  });

  @override
  State<AddCategorySheet> createState() => _AddCategorySheetState();
}

class _AddCategorySheetState extends State<AddCategorySheet> {
  // smallカテゴリーの入力
  bool _canInputSmallCategory = false;
  final TextEditingController _smallCategoryInputController =
      TextEditingController();

  bool get _smallCategoryNameIsEntered =>
      _smallCategoryInputController.text.trim().isNotEmpty;

  // 既存のbigCategory利用時
  TLCategory _selectedBigCategoryInDropButton =
      TLWorkspace.currentWorkspace.bigCategories[0];

  void addSmallCategoryAction() {
    final String newSmallCategoryId = UniqueKey().toString();
    // small categoryの追加
    TLWorkspace
        .currentWorkspace.smallCategories[_selectedBigCategoryInDropButton.id]!
        .add(TLCategory(
            id: newSmallCategoryId, title: _smallCategoryInputController.text));
    // todosを更新する
    TLWorkspace.currentWorkspace.toDos[newSmallCategoryId] =
        TLToDos(toDosInToday: [], toDosInWhenever: []);
    notifyCategoryIsAdded(
        context: context,
        addedCategoryName: _smallCategoryInputController.text);
    // 初期化処理
    _smallCategoryInputController.clear();
    categoryListPageKey.currentState?.setState(() {});
    // toDosとgroupedCategoriesを保存する
    TLCategory.saveSmallCategories();
    TLWorkspace.saveSelectedWorkspace(
      selectedWorkspaceIndex: TLWorkspace.currentWorkspaceIndex,
      selectedWorkspace: TLWorkspace.currentWorkspace,
    );
  }

// ---  カテゴリー追加系の変数
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(30)),
      child: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width - 10,
        child: Column(
          children: [
            // ドロップダウンで既存のbigCategoryから選ぶ
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: DropdownButton<TLCategory>(
                  isExpanded: true,
                  hint: Text(
                    (() {
                      final options = TLWorkspace.currentWorkspace.bigCategories
                          .where((bigCategory) =>
                              bigCategory.id ==
                              _selectedBigCategoryInDropButton.id);
                      if (options.first.id == noneId) {
                        return "大カテゴリー";
                      } else {
                        return options.first.title;
                      }
                    }()),
                  ),
                  items: [
                    ...TLWorkspace.currentWorkspace.bigCategories,
                    TLCategory(id: "---makeBigCategory", title: "新しく作る"),
                  ].map((TLCategory bigCategory) {
                    return DropdownMenuItem(
                      value: bigCategory,
                      child: Text(
                        bigCategory.title,
                        style: bigCategory.id ==
                                _selectedBigCategoryInDropButton.id
                            ? TextStyle(
                                color: theme[SettingData.shared.selectedTheme]!
                                    .accentColor,
                                fontWeight: FontWeight.bold)
                            : TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                  onChanged: (TLCategory? newBigCategory) async {
                    if (newBigCategory != null) {
                      switch (newBigCategory.id) {
                        case "---makeBigCategory":
                          _selectedBigCategoryInDropButton =
                              await addToDoCategoryAlert(
                                      context: context,
                                      categoryNameInputController:
                                          TextEditingController(),
                                      bigCategoryId: null) ??
                                  TLWorkspace.currentWorkspace.bigCategories[0];
                          _canInputSmallCategory = true;
                          categoryListPageKey.currentState?.setState(() {});
                          break;
                        case noneId:
                          _selectedBigCategoryInDropButton = newBigCategory;
                          _canInputSmallCategory = false;
                        default:
                          _selectedBigCategoryInDropButton = newBigCategory;
                          _canInputSmallCategory = true;
                      }
                    }
                    setState(() {});
                  },
                ),
              ),
            ),

            // smallCategoryのtextFromField
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,

              // smallCategoryのTextFormField
              child: TextFormField(
                cursorColor:
                    theme[SettingData.shared.selectedTheme]!.accentColor,
                controller: _smallCategoryInputController,
                readOnly: !_canInputSmallCategory,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.45),
                  fontWeight: FontWeight.bold,
                ),
                decoration: tlInputDecoration(
                    labelText:
                        SettingData.shared.englishMode ? "Small" : "小カテゴリー",
                    icon: null,
                    suffixIcon: null),
                onChanged: (_) => setState(() {}),
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // 閉じる、追加するボタン
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 閉じるボタン
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "閉じる",
                    style: TextStyle(
                        color: theme[SettingData.shared.selectedTheme]!
                            .accentColor),
                  ),
                ),

                // 追加ボタン
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 230),
                  opacity: _selectedBigCategoryInDropButton.id != noneId &&
                          _smallCategoryNameIsEntered
                      // 追加ボタンを使うことができる,
                      ? 1
                      : 0.5,
                  // 追加ボタン
                  child: TextButton(
                    onPressed: _selectedBigCategoryInDropButton.id != noneId &&
                            _smallCategoryNameIsEntered
                        ? addSmallCategoryAction
                        : null,
                    child: Text(
                      "追加する",
                      style: TextStyle(
                          color: // 新しくbigCategoryを作るモードでbigCategoryがnullではない場合や
                              _selectedBigCategoryInDropButton.id != noneId &&
                                      _smallCategoryNameIsEntered
                                  // 追加ボタンを使うことができる
                                  ? theme[SettingData.shared.selectedTheme]!
                                      .accentColor
                                  : Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            // スペーサー
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
