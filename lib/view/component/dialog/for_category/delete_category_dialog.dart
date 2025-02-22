import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class DeleteCategoryDialog extends ConsumerWidget with TLBaseDialogMixin {
  final TLWorkspace corrWorkspace;
  final TLToDoCategory categoryToDelete;

  const DeleteCategoryDialog({
    super.key,
    required this.corrWorkspace,
    required this.categoryToDelete,
  });

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);

    return Dialog(
      backgroundColor: theme.alertBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogTitle(theme: theme),
            const _WarningText(),
            _ActionButtons(
              context: context,
              ref: ref,
              theme: theme,
              corrWorkspace: corrWorkspace,
              categoryToDelete: categoryToDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogTitle extends StatelessWidget {
  final TLThemeConfig theme;

  const _DialogTitle({required this.theme});

  @override
  Widget build(BuildContext context) {
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
}

class _WarningText extends StatelessWidget {
  const _WarningText();

  @override
  Widget build(BuildContext context) {
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
}

class _ActionButtons extends StatelessWidget {
  final BuildContext context;
  final WidgetRef ref;
  final TLThemeConfig theme;
  final TLWorkspace corrWorkspace;
  final TLToDoCategory categoryToDelete;

  const _ActionButtons({
    required this.context,
    required this.ref,
    required this.theme,
    required this.corrWorkspace,
    required this.categoryToDelete,
  });

  @override
  Widget build(BuildContext context) {
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
            ref.read(tlAppStateProvider.notifier).dispatchToDoCategoryAction(
                TLToDoCategoryAction.deleteCategory(
                    corrWorkspace: corrWorkspace,
                    newCategory: categoryToDelete));
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
}
