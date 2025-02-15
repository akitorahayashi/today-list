import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/category_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class RenameCategoryDialog extends HookConsumerWidget with TLBaseDialogMixin {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;

  const RenameCategoryDialog({
    super.key,
    required this.indexOfBigCategory,
    required this.indexOfSmallCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final enteredCategoryTitle = useState<String>("");
    final selectedBigCategoryID = useState<String?>(null);
    final currentWorkspace = ref
        .watch(tlAppStateProvider.select((state) => state.getCurrentWorkspace));

    useEffect(() {
      _initializeCategoryData(enteredCategoryTitle, selectedBigCategoryID);
      return null;
    }, const []);

    final navigator = Navigator.of(context);

    return AddOrEditCategoryDialog(
      title: "カテゴリーを変更",
      buttonText: "変更",
      selectedBigCategoryID: selectedBigCategoryID,
      enteredCategoryTitle: enteredCategoryTitle,
      currentWorkspace: currentWorkspace,
      onSubmit: (newCategoryName, selectedBigCatID) {
        _renameCategory(newCategoryName, selectedBigCatID, navigator);
      },
    );
  }

  void _initializeCategoryData(
    ValueNotifier<String> enteredCategoryTitle,
    ValueNotifier<String?> selectedBigCategoryID,
  ) {
    // もともとEditingCategoryを使って初期化していた処理をローカルステートで代用
    // 例: selectedBigCategoryID.value = "..."
    // 例: enteredCategoryTitle.value = "..."
  }

  void _renameCategory(
    String newCategoryName,
    String? selectedBigCatID,
    NavigatorState navigator,
  ) {
    TLVibrationService.vibrate();
    TLValidation.validateNameAndExecute(
      context: navigator.context,
      name: newCategoryName,
      validator: TLValidation.validateCategoryName,
      onSuccess: () async {
        // TODO カテゴリーの変更
        navigator.pop();
        const TLSingleOptionDialog(title: "カテゴリーが\n変更されました！")
            .show(context: navigator.context);
      },
    );
  }
}
