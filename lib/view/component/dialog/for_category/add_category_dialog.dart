import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_category_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';

class AddCategoryDialog extends HookConsumerWidget with TLBaseDialogMixin {
  final TLWorkspace corrWorkspace;
  final String? parentBigCategoryID;

  const AddCategoryDialog({
    super.key,
    required this.corrWorkspace,
    required this.parentBigCategoryID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final selectedBigCategoryID = useState<String?>(parentBigCategoryID);
    final enteredCategoryTitle = useState<String>("");

    return TLDialog(
      corrThemeConfig: tlThemeConfig,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 18.0),
            child: _BigCategoryDropdown(
              theme: tlThemeConfig,
              corrWorkspace: corrWorkspace,
              selectedBigCategoryID: selectedBigCategoryID.value,
              onChanged: (String? newBigCategoryId) {
                if (newBigCategoryId != corrWorkspace.id) {
                  selectedBigCategoryID.value = newBigCategoryId;
                } else {
                  selectedBigCategoryID.value = null;
                }
              },
            ),
          ),
          _NewCategoryNameInputField(
            theme: tlThemeConfig,
            enteredCategoryTitle: enteredCategoryTitle,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _ActionButtons(
              theme: tlThemeConfig,
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
                        corrWorkspace: corrWorkspace,
                        newCategory: categoryToAdd,
                      ),
                    );
                Navigator.pop(context, categoryToAdd);
                TLSingleOptionDialog(
                  title: categoryToAdd.name,
                  message: "Category has been added!",
                ).show(context: context);
              },
            ),
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
    return SizedBox(
      width: 230,
      child: DropdownButton<String>(
        isExpanded: true,
        hint: _buildDropdownHint(selectedBigCategoryID, corrWorkspace),
        items: [
          TLToDoCategory(
              id: corrWorkspace.id,
              parentBigCategoryID: null,
              name: "UnSelect"),
          ...corrWorkspace.bigCategories,
        ].map((TLToDoCategory bigCategory) {
          return DropdownMenuItem(
            value: bigCategory.id,
            child: Text(
              bigCategory.name,
              style: TextStyle(
                color: bigCategory.id == selectedBigCategoryID
                    ? theme.accentColor
                    : Colors.black.withOpacity(0.5),
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdownHint(String? selectedID, TLWorkspace workspace) {
    if (selectedID == null) return const Text("Not selected");
    final found = workspace.bigCategories.where((bc) => bc.id == selectedID);
    return found.isEmpty
        ? const Text("Not selected")
        : Text(found.first.name,
            style: const TextStyle(fontWeight: FontWeight.bold));
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
  final ValueNotifier<String> enteredCategoryTitle;
  final VoidCallback onClose;
  final VoidCallback onSubmit;

  const _ActionButtons({
    required this.theme,
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
          child: const Text("Add"),
        ),
      ],
    );
  }
}
