import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class AddCategoryDialog extends HookConsumerWidget with TLBaseDialogMixin {
  final TLWorkspace currentWorkspace;

  const AddCategoryDialog({
    super.key,
    required this.currentWorkspace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final selectedBigCategoryID = useState<String?>(null);
    final enteredCategoryTitle = useState<String>("");

    return AlertDialog(
      backgroundColor: theme.alertBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _BigCategoryDropdown(
            theme: theme,
            corrWorkspace: currentWorkspace,
            selectedBigCategoryID: selectedBigCategoryID.value,
            onChanged: (String? newBigCategoryId) {
              selectedBigCategoryID.value = newBigCategoryId;
            },
          ),
          _NewCategoryNameInputField(
            theme: theme,
            enteredCategoryTitle: enteredCategoryTitle,
          ),
          _ActionButtons(
            theme: theme,
            buttonText: "Add",
            enteredCategoryTitle: enteredCategoryTitle,
            onClose: () => Navigator.pop(context),
            onSubmit: () {
              final categoryToAdd = TLToDoCategory(
                id: TLUUIDGenerator.generate(),
                parentBigCategoryID: selectedBigCategoryID.value,
                name: enteredCategoryTitle.value,
              );
              ref.read(tlAppStateProvider.notifier).updateState(
                    TLToDoCategoryAction.addCategory(
                      workspaceID: currentWorkspace.id,
                      newCategory: categoryToAdd,
                    ),
                  );
              Navigator.pop(context);
              TLSingleOptionDialog(
                title: categoryToAdd.name,
                message: "Category has been added!",
              ).show(context: context);
            },
          ),
        ],
      ),
    );
  }
}

class _BigCategoryDropdown extends StatelessWidget {
  final TLThemeConfig theme;
  final TLWorkspace corrWorkspace;
  final String? selectedBigCategoryID;
  final ValueChanged<String?> onChanged;

  const _BigCategoryDropdown({
    required this.theme,
    required this.corrWorkspace,
    required this.selectedBigCategoryID,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 18.0),
      child: SizedBox(
        width: 230,
        child: DropdownButton<String>(
          isExpanded: true,
          hint: _buildDropdownHint(selectedBigCategoryID, corrWorkspace),
          items: [
            TLToDoCategory(
                id: corrWorkspace.id, parentBigCategoryID: null, name: "なし"),
            ...corrWorkspace.bigCategories.sublist(1),
          ].map((TLToDoCategory bigCategory) {
            return DropdownMenuItem(
              value: bigCategory.id,
              child: Text(
                bigCategory.name,
                style: _getDropdownItemStyle(
                  theme,
                  bigCategory.id == selectedBigCategoryID,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDropdownHint(String? selectedID, TLWorkspace workspace) {
    if (selectedID == null) return const Text("None");
    final found = workspace.bigCategories.where((bc) => bc.id == selectedID);
    return found.isEmpty
        ? const Text("None")
        : Text(found.first.name,
            style: const TextStyle(fontWeight: FontWeight.bold));
  }

  TextStyle _getDropdownItemStyle(TLThemeConfig theme, bool isSelected) {
    return TextStyle(
      color: isSelected ? theme.accentColor : Colors.black.withOpacity(0.5),
      fontWeight: FontWeight.bold,
    );
  }
}

class _NewCategoryNameInputField extends StatelessWidget {
  final TLThemeConfig theme;
  final ValueNotifier<String> enteredCategoryTitle;

  const _NewCategoryNameInputField({
    required this.theme,
    required this.enteredCategoryTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox(
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
            labelText: "New Category Name",
            icon: null,
            suffixIcon: null,
          ),
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final TLThemeConfig theme;
  final String buttonText;
  final ValueNotifier<String> enteredCategoryTitle;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  const _ActionButtons({
    required this.theme,
    required this.buttonText,
    required this.enteredCategoryTitle,
    required this.onClose,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
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
