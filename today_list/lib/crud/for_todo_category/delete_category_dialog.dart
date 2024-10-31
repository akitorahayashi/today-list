import 'package:flutter/material.dart';
import '../../alerts/simple_alert.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/external/tl_vibration.dart';
import '../../constants/styles.dart';

Future<void> confirmToDeleteThisCategory({
  required BuildContext context,
  // bigCategoryはworkspace categoryでは適当に
  required int? indexOfWorkspaceCategory,
  required int indexOfBigCategory,
  required int? indexOfSmallCategory,
}) async {
  final TLThemeData _tlThemeData = TLTheme.of(context);
  // 本当に削除するか確認するアラート
  final TLCategory categoryThisBelongsTo = indexOfSmallCategory == null
      ? TLWorkspace.currentWorkspace.bigCategories[indexOfBigCategory]
      : TLWorkspace.currentWorkspace.smallCategories[TLWorkspace
          .currentWorkspace
          .bigCategories[indexOfBigCategory]
          .id]![indexOfSmallCategory];
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: _tlThemeData.alertColor,
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
                        color: _tlThemeData.accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    indexOfWorkspaceCategory == null
                        ? "※関連するToDoやCategoryが\n一緒に削除されます"
                        : "※関連するWorkspaceが\n一緒に削除されます",
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
                        style: alertButtonStyle(
                            accentColor: _tlThemeData.accentColor),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("いいえ")),
                    TextButton(
                        style: alertButtonStyle(
                            accentColor: _tlThemeData.accentColor),
                        onPressed: () async {
                          if (indexOfSmallCategory != null) {
                            // このカテゴリーがsmallCategoryの場合
                            // カテゴリーのリストから削除する
                            TLWorkspace
                                .currentWorkspace
                                .smallCategories[TLWorkspace.currentWorkspace
                                    .bigCategories[indexOfBigCategory].id]!
                                .removeWhere(((TLCategory smallCategory) =>
                                    smallCategory.id ==
                                    categoryThisBelongsTo.id));
                            // toDosに入っているものを消す
                            TLWorkspace.currentWorkspace.toDos
                                .remove(categoryThisBelongsTo.id);
                          } else {
                            // このカテゴリーがbigCategoryの場合
                            // bigCategoryのsmallCategoryでtoDosに入っているものを消す
                            for (TLCategory smallCategory
                                in TLWorkspace.currentWorkspace.smallCategories[
                                    TLWorkspace
                                        .currentWorkspace
                                        .bigCategories[indexOfBigCategory]
                                        .id]!) {
                              TLWorkspace.currentWorkspace.toDos
                                  .remove(smallCategory.id);
                            } // toDosに入っているものを消す
                            TLWorkspace.currentWorkspace.toDos
                                .remove(categoryThisBelongsTo.id);
                            // カテゴリーのリストからbigCategoryとsmallCategoryを削除する
                            TLWorkspace.currentWorkspace.bigCategories
                                .removeAt(indexOfBigCategory);
                            TLWorkspace.currentWorkspace.smallCategories
                                .remove(categoryThisBelongsTo.id);
                          }

                          // categoriesとtoDosを保存する
                          if (indexOfSmallCategory == null) {
                            TLCategory.saveBigCategories();
                          } else {
                            TLCategory.saveSmallCategories();
                          }
                          TLWorkspace.saveSelectedWorkspace(
                              selectedWorkspaceIndex:
                                  TLWorkspace.currentWorkspaceIndex);
                          Navigator.pop(context);
                          // アラートを消す
                          Navigator.pop(context);
                          TLVibration.vibrate();
                          // 知らせるアラート
                          simpleAlert(
                            context: context,
                            corrThemeData: _tlThemeData,
                            title: "削除することに成功しました!",
                            message: null,
                            buttonText: "OK",
                          );
                        },
                        child: const Text("はい")),
                  ],
                )
              ],
            ),
          ),
        );
      });
}
