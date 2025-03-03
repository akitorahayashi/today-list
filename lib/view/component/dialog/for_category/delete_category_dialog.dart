import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';

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
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    return TLDialog(
      corrThemeConfig: tlThemeConfig,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 32),
              child: Text(
                "Delete This Category?",
                style: TextStyle(
                  color: tlThemeConfig.accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: _WarningText(),
            ),
            _ActionButtons(
              context: context,
              ref: ref,
              theme: tlThemeConfig,
              corrWorkspace: corrWorkspace,
              categoryToDelete: categoryToDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _WarningText extends StatelessWidget {
  const _WarningText();

  @override
  Widget build(BuildContext context) {
    return Text(
      "Related ToDos and categories will be deleted together",
      style: TextStyle(
        color: Colors.black.withValues(alpha: 0.6),
        fontWeight: FontWeight.w600,
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
          child: const Text("Close"),
        ),
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () async {
            ref.read(tlAppStateProvider.notifier).updateState(
                TLToDoCategoryAction.deleteCategory(
                    corrWorkspace: corrWorkspace,
                    categoryToDelete: categoryToDelete));
            Navigator.pop(context);
            const TLSingleOptionDialog(title: "Successfully deleted!")
                .show(context: context);
          },
          child: const Text("Delete"),
        ),
      ],
    );
  }
}
