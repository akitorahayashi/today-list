import 'package:flutter/material.dart';
import 'package:today_list/components/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/styles/styles.dart';

class DeleteCategoryDialog extends StatelessWidget {
  const DeleteCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Dialog(
      backgroundColor: tlThemeData.alertColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16),
              child: Text(
                "本当にこのカテゴリーを\n削除しますか？",
                style: TextStyle(
                    color: tlThemeData.accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "※関連するToDoやCategoryが\n一緒に削除されます",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    style:
                        alertButtonStyle(accentColor: tlThemeData.accentColor),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("いいえ")),
                TextButton(
                    style:
                        alertButtonStyle(accentColor: tlThemeData.accentColor),
                    onPressed: () async {
                      if (indexOfSmallCategory != null) {
                        // このカテゴリーがsmallCategoryの場合
                        // カテゴリーのリストから削除する
                        currentWorkspace.smallCategories[currentWorkspace
                                .bigCategories[indexOfBigCategory].id]!
                            .removeWhere(((Category smallCategory) =>
                                smallCategory.id == categoryThisBelongsTo.id));
                        // toDosに入っているものを消す
                        currentWorkspace.toDos.remove(categoryThisBelongsTo.id);
                      } else {
                        // このカテゴリーがbigCategoryの場合
                        // bigCategoryのsmallCategoryでtoDosに入っているものを消す
                        for (Category smallCategory
                            in currentWorkspace.smallCategories[currentWorkspace
                                .bigCategories[indexOfBigCategory].id]!) {
                          currentWorkspace.toDos.remove(smallCategory.id);
                        } // toDosに入っているものを消す
                        currentWorkspace.toDos.remove(categoryThisBelongsTo.id);
                        // カテゴリーのリストからbigCategoryとsmallCategoryを削除する
                        currentWorkspace.bigCategories
                            .removeAt(indexOfBigCategory);
                        currentWorkspace.smallCategories
                            .remove(categoryThisBelongsTo.id);
                      }

                      // categoriesとtoDosを保存する
                      if (indexOfSmallCategory == null) {
                        Category.saveBigCategories();
                      } else {
                        Category.saveSmallCategories();
                      }
                      Workspace.saveSelectedWorkspace(
                        selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                        selectedWorkspaceIndex: currentWorkspaceIndex,
                        selectedWorkspace: currentWorkspace,
                      );
                      Navigator.pop(context);
                      // アラートを消す
                      Navigator.pop(context);
                      TLVibration.vibrate();
                      // 知らせるアラート
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const TLSingleOptionDialog(
                                title: "削除することに\n成功しました!", message: null);
                          });
                    },
                    child: const Text("はい")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
