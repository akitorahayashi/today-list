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
    final enteredCategoryTitle = useState<String>(categoryToRename.name);

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
                initialText: categoryToRename.name,
              ),
            ),
          ),
          _ActionButtons(
            buttonText: "Change",
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
                  ref.read(tlAppStateProvider.notifier).dispatch(
                      TLToDoCategoryAction.updateCategory(
                          workspaceID: corrWorkspaceID,
                          newCategory: newCategory));
                  navigator.pop();
                  const TLSingleOptionDialog(
                          title: "Category name\nhas been changed!")
                      .show(context: navigator.context);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _NewCategoryNameInputField extends HookWidget {
  final ValueNotifier<String> enteredCategoryTitle;
  final String initialText;

  const _NewCategoryNameInputField({
    required this.enteredCategoryTitle,
    required this.initialText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = TLTheme.of(context);
    final textController = useTextEditingController(text: initialText);

    useEffect(() {
      return () => textController.dispose();
    }, [textController]);

    return SizedBox(
      width: 230,
      child: TextField(
        controller: textController,
        autofocus: true,
        onChanged: (text) => enteredCategoryTitle.value = text,
        cursorColor: theme.accentColor,
        style: TextStyle(
          color: Colors.black.withOpacity(0.5),
          fontWeight: FontWeight.w600,
        ),
        decoration: tlInputDecoration(
          context: context,
          labelText: "New Category Name",
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
          child: const Text("Close"),
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
