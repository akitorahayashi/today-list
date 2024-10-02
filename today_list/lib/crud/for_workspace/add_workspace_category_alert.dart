import 'package:flutter/material.dart';
import 'package:today_list/constants/global_keys.dart';
import '../../model/tl_category.dart';
import '../../model/workspace/workspace.dart';
import '../../model/workspace/id_to_jsonworkspaceList.dart';
import '../../model/user/setting_data.dart';
import '../../model/externals/tl_vibration.dart';
import '../for_todo_category/notify_category_is_added.dart';
import '../../constants/theme.dart';
import '../../styles.dart';

Future<TLCategory?> addWorkspaceCategoryAlert({
  required BuildContext context,
  required TextEditingController categoryNameInputController,
}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme[settingData.selectedTheme]!.alertColor,
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
                          theme[settingData.selectedTheme]!.accentColor,
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w600),
                      decoration: tlInputDecoration(
                          labelText: "新しいカテゴリー名", icon: null, suffixIcon: null),
                    )),
              ),
              // 閉じる 追加するボタン
              ButtonBar(
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
                          workspaceCategories.add(TLCategory(
                              id: newCategoryId,
                              title: categoryNameInputController.text));
                          // workspacesを更新
                          workspaces[newCategoryId] = [];
                          // 保存
                          TLCategory.saveWorkspaceCategories();
                          Workspace.saveSelectedWorkspace(
                            selectedWorkspaceCategoryId:
                                currentWorkspaceCategoryId,
                            selectedWorkspaceIndex: currentWorkspaceIndex,
                            selectedWorkspace: currentWorkspace,
                          );
                          Navigator.pop(context);
                          // ignore: invalid_use_of_protected_member
                          drawerForWorkspaceKey.currentState?.setState(() {});
                          // ignore: invalid_use_of_protected_member
                          manageWorkspacePageKey.currentState?.setState(() {});
                          TLVibration.vibrate();
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
