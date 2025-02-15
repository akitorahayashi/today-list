import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class RenameCategoryDialog extends HookConsumerWidget with TLBaseDialogMixin {
  final String corrWorkspaceID;
  final TLToDoCategory categoryToRename;

  const RenameCategoryDialog({
    super.key,
    required this.corrWorkspaceID,
    required this.categoryToRename,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enteredCategoryTitle = useState<String>("");
    final String currentWorkspaceID = ref
        .watch(tlAppStateProvider.select((state) => state.currentWorkspaceID));

    useEffect(() {
      _initializeCategoryData(enteredCategoryTitle);
      return null;
    }, const []);

    final navigator = Navigator.of(context);

    return AlertDialog(
      backgroundColor: TLTheme.of(context).alertBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _NewCategoryNameInputField(
                enteredCategoryTitle: enteredCategoryTitle,
              ),
            ),
          ),
          _ActionButtons(
            buttonText: "変更",
            enteredCategoryTitle: enteredCategoryTitle,
            onClose: () => Navigator.pop(context),
            onSubmit: () {
              final newCategory = TLToDoCategory(
                id: categoryToRename.id,
                parentBigCategoryID: categoryToRename.parentBigCategoryID,
                name: enteredCategoryTitle.value,
              );
              TLVibrationService.vibrate();
              TLValidation.validateNameAndExecute(
                context: navigator.context,
                name: newCategory.name,
                validator: TLValidation.validateCategoryName,
                onSuccess: () async {
                  ref
                      .read(tlAppStateProvider.notifier)
                      .dispatchToDoCategoryAction(
                          TLToDoCategoryAction.updateCategory(
                              workspaceID: currentWorkspaceID,
                              newCategory: newCategory));
                  navigator.pop();
                  const TLSingleOptionDialog(title: "カテゴリーが\n変更されました！")
                      .show(context: navigator.context);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void _initializeCategoryData(ValueNotifier<String> enteredCategoryTitle) {
    enteredCategoryTitle.value = categoryToRename.name;
  }
}

class _NewCategoryNameInputField extends StatelessWidget {
  final ValueNotifier<String> enteredCategoryTitle;

  const _NewCategoryNameInputField({
    required this.enteredCategoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TLTheme.of(context);
    return SizedBox(
      width: 230,
      child: TextField(
        autofocus: true,
        onChanged: (text) => enteredCategoryTitle.value = text,
        cursorColor: theme.accentColor,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
        decoration: tlInputDecoration(
          context: context,
          labelText: "新しいカテゴリー名",
          icon: null,
          suffixIcon: null,
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final String buttonText;
  final ValueNotifier<String> enteredCategoryTitle;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  const _ActionButtons({
    required this.buttonText,
    required this.enteredCategoryTitle,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TLTheme.of(context);
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: onClose,
          child: const Text("閉じる"),
        ),
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed:
              enteredCategoryTitle.value.trim().isEmpty ? null : onSubmit,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
