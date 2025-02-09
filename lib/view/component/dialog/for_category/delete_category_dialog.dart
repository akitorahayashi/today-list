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

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final TLWorkspace currentWorkspace = ref.watch(
      tlAppStateProvider.select((state) => state.getCurrentWorkspace),
    );

    final TLCategory? categoryToDelete = _getCategory(currentWorkspace);

    if (categoryToDelete == null) {
      return _buildErrorDialog(theme);
    }

    return _buildConfirmationDialog(
        context, ref, theme, currentWorkspace, categoryToDelete);
  }

  // MARK: - Category Retrieval
  TLCategory? _getCategory(TLWorkspace workspace) {
    if (indexOfSmallCategory == null) {
      return (indexOfBigCategory >= 0 &&
              indexOfBigCategory < workspace.bigCategories.length)
          ? workspace.bigCategories[indexOfBigCategory]
          : null;
    } else {
      final String bigCategoryId =
          workspace.bigCategories[indexOfBigCategory].id;
      final List<TLCategory>? smallCategories =
          workspace.smallCategories[bigCategoryId];
      return (smallCategories != null &&
              indexOfSmallCategory! >= 0 &&
              indexOfSmallCategory! < smallCategories.length)
          ? smallCategories[indexOfSmallCategory!]
          : null;
    }
  }

  // MARK: - UI Components
  Widget _buildErrorDialog(TLThemeConfig theme) {
    return Dialog(
      backgroundColor: theme.alertBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "Error: カテゴリーが見つかりませんでした",
          style: TextStyle(color: theme.accentColor, fontSize: 20),
        ),
      ),
    );
  }

  Widget _buildConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
    TLThemeConfig theme,
    TLWorkspace workspace,
    TLCategory categoryToDelete,
  ) {
    return Dialog(
      backgroundColor: theme.alertBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTitle(theme),
            _buildWarningText(),
            _buildActionButtons(
                context, ref, theme, workspace, categoryToDelete),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogTitle(TLThemeConfig theme) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
      child: Text(
        "本当にこのカテゴリーを\n削除しますか？",
        style: TextStyle(
          color: theme.accentColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildWarningText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        "※関連するToDoやCategoryが\n一緒に削除されます",
        style: TextStyle(
          color: Colors.black.withOpacity(0.6),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    WidgetRef ref,
    TLThemeConfig theme,
    TLWorkspace workspace,
    TLCategory categoryToDelete,
  ) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("いいえ"),
        ),
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () async {
            _deleteCategory(ref, workspace, categoryToDelete);
            Navigator.pop(context);
            TLVibrationService.vibrate();
            const TLSingleOptionDialog(title: "削除することに\n成功しました!")
                .show(context: context);
          },
          child: const Text("はい"),
        ),
      ],
    );
  }

  // MARK: - Category Deletion
  void _deleteCategory(
      WidgetRef ref, TLWorkspace workspace, TLCategory categoryToDelete) {
    final List<TLCategory> updatedBigCategories =
        List<TLCategory>.from(workspace.bigCategories);
    final Map<String, List<TLCategory>> updatedSmallCategories = {
      for (var entry in workspace.smallCategories.entries)
        entry.key: List<TLCategory>.from(entry.value),
    };
    final Map<String, TLToDosInTodayAndWhenever> updatedCategoryIDToToDos = {
      for (var entry in workspace.categoryIDToToDos.entries)
        if (entry.key != categoryToDelete.id) entry.key: entry.value,
    };

    if (indexOfSmallCategory != null) {
      final String bigCategoryId =
          workspace.bigCategories[indexOfBigCategory].id;
      updatedSmallCategories[bigCategoryId]?.removeWhere(
        (smallCategory) => smallCategory.id == categoryToDelete.id,
      );
    } else {
      final String bigCategoryId = categoryToDelete.id;
      updatedSmallCategories.remove(bigCategoryId);
      updatedBigCategories.removeAt(indexOfBigCategory);

      // smallCategories 内の関連タスクを削除
      if (workspace.smallCategories[bigCategoryId] != null) {
        for (TLCategory smallCategory
            in workspace.smallCategories[bigCategoryId]!) {
          updatedCategoryIDToToDos.remove(smallCategory.id);
        }
      }
    }

    // ワークスペースの更新を適用
    ref.read(tlAppStateProvider.notifier).dispatchWorkspaceAction(
          TLWorkspaceAction.updateCurrentWorkspace(
            workspace.copyWith(
              bigCategories: updatedBigCategories,
              smallCategories: updatedSmallCategories,
              categoryIDToToDos: updatedCategoryIDToToDos,
            ),
          ),
        );
  }
}
