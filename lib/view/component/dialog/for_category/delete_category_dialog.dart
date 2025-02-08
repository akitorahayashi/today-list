import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../service/tl_vibration.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/todo/tl_todos_in_today_and_whenever.dart';
import '../../../../styles.dart';

class DeleteCategoryDialog extends ConsumerWidget with TLBaseDialogMixin {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;
  const DeleteCategoryDialog({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    // provider
    final tlAppState = ref.watch(tlAppStateProvider);
    // others
    final TLWorkspace currentWorkspaceRef =
        tlAppState.tlWorkspaces[tlAppState.currentWorkspaceIndex];
    // other
    TLCategory? categoryThisBelongsTo;
    if (indexOfSmallCategory == null) {
      if (indexOfBigCategory >= 0 &&
          indexOfBigCategory < currentWorkspaceRef.bigCategories.length) {
        categoryThisBelongsTo =
            currentWorkspaceRef.bigCategories[indexOfBigCategory];
      }
    } else {
      final bigCategoryId =
          currentWorkspaceRef.bigCategories[indexOfBigCategory].id;
      final smallCategories =
          currentWorkspaceRef.smallCategories[bigCategoryId];
      if (smallCategories != null &&
          indexOfSmallCategory! >= 0 &&
          indexOfSmallCategory! < smallCategories.length) {
        categoryThisBelongsTo = smallCategories[indexOfSmallCategory!];
      }
    }

    if (categoryThisBelongsTo == null) {
      return Dialog(
        backgroundColor: tlThemeData.alertColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Error: カテゴリーが見つかりませんでした",
            style: TextStyle(color: tlThemeData.accentColor, fontSize: 20),
          ),
        ),
      );
    }

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

                    // TODO 直接操作している箇所があり危険
                    onPressed: () async {
                      // corrElements
                      final List<TLCategory> corrBigCategories =
                          List<TLCategory>.from(
                              currentWorkspaceRef.bigCategories);
                      final Map<String, List<TLCategory>> corrSmallCategories =
                          {
                        for (var entry
                            in currentWorkspaceRef.smallCategories.entries)
                          entry.key: List<TLCategory>.from(entry.value)
                      };
                      final corrCategoryIDToToDos =
                          Map<String, TLToDosInTodayAndWhenever>.from(
                              currentWorkspaceRef.categoryIDToToDos);
                      if (indexOfSmallCategory != null) {
                        // このカテゴリーがsmallCategoryの場合
                        // カテゴリーのリストから削除する
                        corrSmallCategories[currentWorkspaceRef
                                .bigCategories[indexOfBigCategory].id]!
                            .removeWhere(((TLCategory smallCategory) =>
                                smallCategory.id == categoryThisBelongsTo!.id));
                        // toDosに入っているものを消す
                        corrCategoryIDToToDos.remove(categoryThisBelongsTo!.id);
                      } else {
                        // このカテゴリーがbigCategoryの場合
                        // bigCategoryのsmallCategoryでtoDosに入っているものを消す
                        for (TLCategory smallCategory in corrSmallCategories[
                            categoryThisBelongsTo!.id]!) {
                          corrCategoryIDToToDos.remove(smallCategory.id);
                        }
                        // toDosに入っているものを消す
                        corrCategoryIDToToDos.remove(categoryThisBelongsTo.id);
                        // カテゴリーのリストからbigCategoryとsmallCategoryを削除する
                        corrBigCategories.removeAt(indexOfBigCategory);
                        corrSmallCategories.remove(categoryThisBelongsTo.id);
                      }

                      // categoriesとtoDosを保存する
                      ref
                          .read(tlAppStateProvider.notifier)
                          .dispatchWorkspaceAction(
                              TLWorkspaceAction.updateCurrentWorkspace(
                                  currentWorkspaceRef.copyWith(
                                      bigCategories: corrBigCategories,
                                      smallCategories: corrSmallCategories,
                                      categoryIDToToDos:
                                          corrCategoryIDToToDos)));

                      // アラートを消す
                      Navigator.pop(context);
                      TLVibrationService.vibrate();
                      // 知らせるアラート
                      const TLSingleOptionDialog(title: "削除することに\n成功しました!")
                          .show(context: context);
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
