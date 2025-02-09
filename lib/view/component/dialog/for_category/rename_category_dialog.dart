import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import '../common/tl_single_option_dialog.dart';
import '../../../../redux/store/editing_provider/editing_category_provider.dart';
import '../../../../service/tl_vibration.dart';
import '../../../../model/todo/tl_category.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';
import '../../../../styles.dart';

class RenameCategoryDialog extends ConsumerStatefulWidget
    with TLBaseDialogMixin {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;

  const RenameCategoryDialog({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  ConsumerState<RenameCategoryDialog> createState() =>
      _RenameCategoryDialogState();
}

class _RenameCategoryDialogState extends ConsumerState<RenameCategoryDialog> {
  late EditingCategoryNotifier _editingCategoryNotifier;
  late String _enteredCategoryTitle;

  // MARK: - Lifecycle (Init & Dispose)
  @override
  void initState() {
    super.initState();
    _initializeCategoryData();
  }

  @override
  void dispose() {
    EditingCategory.categoryTitleInputController?.dispose();
    super.dispose();
  }

  // MARK: - Initialization
  void _initializeCategoryData() {
    final tlAppState = ref.read(tlAppStateProvider);
    final TLWorkspace currentWorkspaceRef = tlAppState.getCurrentWorkspace;
    final TLCategory bigCategory =
        currentWorkspaceRef.bigCategories[widget.indexOfBigCategory];

    // カテゴリー名を取得
    final String categoryName = widget.indexOfSmallCategory == null
        ? bigCategory.title
        : currentWorkspaceRef
            .smallCategories[bigCategory.id]![widget.indexOfSmallCategory!]
            .title;

    // Notifierを設定
    _editingCategoryNotifier = ref.read(editingCategoryProvider.notifier);
    EditingCategory.updateTextEditingController(
        editedCategoryTitle: categoryName);
    _enteredCategoryTitle = categoryName;

    // 選択中のカテゴリーを設定
    Future.microtask(() {
      _editingCategoryNotifier.setEditedCategory(
        indexOfEditingBigCategory: widget.indexOfBigCategory,
        indexOfEditingSmallCategory: widget.indexOfSmallCategory,
      );
    });
  }

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig theme = TLTheme.of(context);
    final EditingCategory editingCategory = ref.watch(editingCategoryProvider);
    final TLWorkspace currentWorkspace = ref
        .watch(tlAppStateProvider.select((state) => state.getCurrentWorkspace));

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
          onChanged: (String? newBigCategoryId) =>
              _updateCategoryEditingState(newBigCategoryId),
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
              : () => _renameCategory(),
          child: const Text("変更"),
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
  void _updateCategoryEditingState(String? newBigCategoryId) {
    if (newBigCategoryId == noneID || newBigCategoryId == null) {
      _editingCategoryNotifier.updateEditingCategory(
          selectedBigCatgoeyID: null);
    } else {
      _editingCategoryNotifier.updateEditingCategory(
          selectedBigCatgoeyID: newBigCategoryId);
    }
  }

  void _renameCategory() async {
    TLVibrationService.vibrate();
    await TLValidation.validateNameAndExecute(
      context: context,
      name: _enteredCategoryTitle,
      validator: TLValidation.validateCategoryName,
      onSuccess: () async {
        await _editingCategoryNotifier.completeEditing();
        if (context.mounted) {
          Navigator.pop(context);
          const TLSingleOptionDialog(title: "カテゴリーが\n変更されました！")
              .show(context: context);
        }
      },
    );
  }
}
