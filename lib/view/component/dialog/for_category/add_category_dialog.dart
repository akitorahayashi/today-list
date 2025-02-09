import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_validation.dart';
import '../common/tl_single_option_dialog.dart';
import '../tl_base_dialog_mixin.dart';
import '../../../../redux/store/editing_provider/editing_category_provider.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../service/tl_vibration.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../styles.dart';

class AddCategoryDialog extends ConsumerStatefulWidget with TLBaseDialogMixin {
  const AddCategoryDialog({super.key});

  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  late EditingCategoryNotifier _editingCategoryNotifier;
  String _enteredCategoryTitle = "";

  // MARK: - Lifecycle (Init & Dispose)
  @override
  void initState() {
    super.initState();
    _initializeEditingState();
  }

  @override
  void dispose() {
    EditingCategory.categoryTitleInputController?.dispose();
    super.dispose();
  }

  // MARK: - Initialization
  void _initializeEditingState() {
    _editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    EditingCategory.updateTextEditingController(editedCategoryTitle: null);
    Future.microtask(() {
      _editingCategoryNotifier.setInitialValue();
    });
  }

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig theme = TLTheme.of(context);
    final EditingCategory editingCategory = ref.watch(editingCategoryProvider);
    final TLWorkspace currentWorkspace = ref.watch(
      tlAppStateProvider.select((state) => state.getCurrentWorkspace),
    );

    return AlertDialog(
      backgroundColor: theme.alertBackgroundColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildCategoryDropdown(theme, editingCategory, currentWorkspace),
          _buildCategoryTextField(theme),
          _buildActionButtons(theme),
        ],
      ),
    );
  }

  // MARK: - UI Components
  Widget _buildCategoryDropdown(TLThemeConfig theme,
      EditingCategory editingCategory, TLWorkspace workspace) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 18.0),
      child: SizedBox(
        width: 230,
        child: DropdownButton<String>(
          isExpanded: true,
          hint: _buildDropdownHint(editingCategory, workspace),
          items: [
            const TLCategory(id: noneID, title: "なし"),
            ...workspace.bigCategories.sublist(1),
          ].map((TLCategory bigCategory) {
            return DropdownMenuItem(
              value: bigCategory.id,
              child: Text(
                bigCategory.title,
                style:
                    _getDropdownItemStyle(theme, editingCategory, bigCategory),
              ),
            );
          }).toList(),
          onChanged: _updateEditingCategory,
        ),
      ),
    );
  }

  Widget _buildCategoryTextField(TLThemeConfig theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox(
        width: 230,
        child: TextField(
          autofocus: true,
          controller: EditingCategory.categoryTitleInputController,
          onChanged: (text) => setState(() => _enteredCategoryTitle = text),
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
      ),
    );
  }

  Widget _buildActionButtons(TLThemeConfig theme) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("閉じる"),
        ),
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: _enteredCategoryTitle.trim().isEmpty
              ? null
              : () => _addCategory(),
          child: const Text("追加"),
        ),
      ],
    );
  }

  // MARK: - Helpers
  Widget _buildDropdownHint(
      EditingCategory editingCategory, TLWorkspace workspace) {
    final String? selectedID = editingCategory.selecteBigCategoryID;
    if (selectedID == null) return const Text("なし");

    final hintArray = workspace.bigCategories
        .where((bigCategory) => bigCategory.id == selectedID);
    return hintArray.isEmpty
        ? const Text("なし")
        : Text(hintArray.first.title,
            style: const TextStyle(fontWeight: FontWeight.bold));
  }

  TextStyle _getDropdownItemStyle(TLThemeConfig theme,
      EditingCategory editingCategory, TLCategory bigCategory) {
    final bool isSelected =
        bigCategory.id == editingCategory.selecteBigCategoryID;
    return TextStyle(
      color: isSelected ? theme.accentColor : Colors.black.withOpacity(0.5),
      fontWeight: FontWeight.bold,
    );
  }

  // MARK: - Actions
  void _updateEditingCategory(String? newBigCategoryId) {
    _editingCategoryNotifier.updateEditingCategory(
      selectedBigCatgoeyID:
          newBigCategoryId == noneID ? null : newBigCategoryId,
      indexOfEditingBigCategory: null,
      indexOfEditingSmallCategory: null,
    );
  }

  void _addCategory() async {
    TLVibrationService.vibrate();
    await TLValidation.validateNameAndExecute(
      context: context,
      name: _enteredCategoryTitle,
      validator: TLValidation.validateCategoryName,
      onSuccess: () async {
        await _editingCategoryNotifier.completeEditing();
        if (context.mounted) {
          Navigator.pop(context);
          const TLSingleOptionDialog(title: "カテゴリーが\n追加されました！")
              .show(context: context);
        }
      },
    );
  }
}
