import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/tl_workspaces_provider.dart';
import 'package:today_list/model/todo/tl_category.dart';
import 'package:today_list/model/todo/tl_todos.dart';
import 'package:today_list/styles/styles.dart';

class DeleteCategoryDialog extends ConsumerWidget {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;
  const DeleteCategoryDialog({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    // provider
    final currentWorkspace = ref.watch(currentWorkspaceProvider);
    // notifier
    final TLWorkspacesNotifier tlWorkspacesNotifier =
        ref.read(tlWorkspacesProvider.notifier);
    final CurrentTLWorkspaceNotifier currentWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
    // other
    final TLCategory categoryThisBelongsTo = indexOfSmallCategory == null
        ? currentWorkspace.bigCategories[indexOfBigCategory]
        : currentWorkspace.smallCategories[currentWorkspace
            .bigCategories[indexOfBigCategory].id]![indexOfSmallCategory!];
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
                      // corrElements
                      final List<TLCategory> corrBigCategories =
                          List<TLCategory>.from(currentWorkspace.bigCategories);
                      final Map<String, List<TLCategory>> corrSmallCategories =
                          {
                        for (var entry
                            in currentWorkspace.smallCategories.entries)
                          entry.key: List<TLCategory>.from(entry.value)
                      };
                      final corrCategoryIDToToDos = Map<String, TLToDos>.from(
                          currentWorkspace.categoryIDToToDos);
                      if (indexOfSmallCategory != null) {
                        // このカテゴリーがsmallCategoryの場合
                        // カテゴリーのリストから削除する
                        corrSmallCategories[currentWorkspace
                                .bigCategories[indexOfBigCategory].id]!
                            .removeWhere(((TLCategory smallCategory) =>
                                smallCategory.id == categoryThisBelongsTo.id));
                        // toDosに入っているものを消す
                        corrCategoryIDToToDos.remove(categoryThisBelongsTo.id);
                      } else {
                        // このカテゴリーがbigCategoryの場合
                        // bigCategoryのsmallCategoryでtoDosに入っているものを消す
                        for (TLCategory smallCategory
                            in corrSmallCategories[categoryThisBelongsTo.id]!) {
                          corrCategoryIDToToDos.remove(smallCategory.id);
                        }
                        // toDosに入っているものを消す
                        corrCategoryIDToToDos.remove(categoryThisBelongsTo.id);
                        // カテゴリーのリストからbigCategoryとsmallCategoryを削除する
                        corrBigCategories.removeAt(indexOfBigCategory);
                        corrSmallCategories.remove(categoryThisBelongsTo.id);
                      }

                      // categoriesとtoDosを保存する
                      tlWorkspacesNotifier.updateCurrentWorkspace(
                          updatedWorkspace: currentWorkspace.copyWith(
                              bigCategories: corrBigCategories,
                              smallCategories: corrSmallCategories,
                              categoryIDToToDos: corrCategoryIDToToDos));

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
