import 'package:flutter/material.dart';
import '../../constants/theme.dart';
import '../../model/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/todo/tl_todos.dart';
import '../../model/user/setting_data.dart';
import '../../model/externals/tl_vibration.dart';
import '../../styles.dart';
import 'notify_category_is_added.dart';

Future<TLCategory?> addToDoCategoryAlert({
  required BuildContext context,
  required TextEditingController categoryNameInputController,
  // smallCategoryを作る際に必要
  required String? bigCategoryId,
}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme[SettingData.shared.selectedTheme]!.alertColor,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // スペーサー
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                    width: 230,
                    // 新しいカテゴリー名を入力するTextFormField
                    child: TextField(
                      autofocus: true,
                      controller: categoryNameInputController,
                      cursorColor:
                          theme[SettingData.shared.selectedTheme]!.accentColor,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w600),
                      decoration: tlInputDecoration(
                          labelText: "新しいカテゴリー名", icon: null, suffixIcon: null),
                    )),
              ),
              // 閉じる 追加するボタン
              OverflowBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // カテゴリーを作らずにアラートを閉じるボタン
                  TextButton(
                      style: alertButtonStyle(),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("閉じる")),
                  // カテゴリーを追加するボタン
                  TextButton(
                      style: alertButtonStyle(),
                      onPressed: () {
                        // カテゴリー名が入力されているなら追加する
                        if (categoryNameInputController.text
                            .trim()
                            .isNotEmpty) {
                          final String newCategoryId = UniqueKey().toString();
                          final TLCategory createdCategory = TLCategory(
                              title: categoryNameInputController.text,
                              id: newCategoryId);
                          if (bigCategoryId == null) {
                            // bigCategoryを追加する場合
                            // IDがユニークなら追加する
                            if (() {
                              final bigCategories =
                                  TLWorkspace.currentWorkspace.bigCategories;
                              for (int index = 0;
                                  index < bigCategories.length;
                                  index++) {
                                if (bigCategories[index].id == newCategoryId) {
                                  return false;
                                }
                              }
                              return true;
                            }()) {
                              // ToDoBigカテゴリーを追加する
                              TLWorkspace.currentWorkspace.bigCategories
                                  .add(createdCategory);
                              TLWorkspace.currentWorkspace
                                  .smallCategories[newCategoryId] = [];
                            } else {
                              // 抜ける
                              Navigator.pop(context);
                            }
                          } else {
                            // smallCategoryを追加する場合
                            // IDがユニークなら追加する
                            if (() {
                              for (String bigCategoryId in TLWorkspace
                                  .currentWorkspace.smallCategories.keys) {
                                for (TLCategory smallCategory in TLWorkspace
                                    .currentWorkspace
                                    .smallCategories[bigCategoryId]!) {
                                  if (smallCategory.id == newCategoryId) {
                                    return false;
                                  }
                                }
                              }
                              return true;
                            }()) {
                              // ToDoSmallCategoryを追加する
                              TLWorkspace.currentWorkspace
                                  .smallCategories[bigCategoryId]!
                                  .add(createdCategory);
                            }
                          }
                          // toDosを更新
                          TLWorkspace.currentWorkspace.toDos[newCategoryId] =
                              TLToDos(toDosInToday: [], toDosInWhenever: []);
                          // 保存
                          bigCategoryId == null
                              ? TLCategory.saveBigAndSmallCategories()
                              : TLCategory.saveSmallCategories();

                          TLWorkspace.saveSelectedWorkspace(
                            selectedWorkspaceIndex:
                                TLWorkspace.currentWorkspaceIndex,
                            selectedWorkspace: TLWorkspace.currentWorkspace,
                          );
                          TLVibration.vibrate();
                          categoryNameInputController.clear();
                          Navigator.pop(context, createdCategory);
                          notifyCategoryIsAdded(
                              context: context,
                              addedCategoryName:
                                  categoryNameInputController.text);
                        } else {
                          // 入力されていなかった場合、出る
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("追加"))
                ],
              )
            ],
          ),
        );
      });
}
