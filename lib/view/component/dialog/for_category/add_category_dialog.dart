import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/category_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class AddCategoryDialog extends HookConsumerWidget with TLBaseDialogMixin {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final enteredCategoryTitle = useState<String>("");
    final selectedBigCategoryID = useState<String?>(null);
    final currentWorkspace = ref
        .watch(tlAppStateProvider.select((state) => state.getCurrentWorkspace));

    return AddOrEditCategoryDialog(
      title: "カテゴリーを追加",
      buttonText: "追加",
      selectedBigCategoryID: selectedBigCategoryID,
      enteredCategoryTitle: enteredCategoryTitle,
      currentWorkspace: currentWorkspace,
      onSubmit: (newCategoryName, selectedBigCatID) {
        _addCategory(context, newCategoryName);
      },
    );
  }

  void _addCategory(BuildContext context, String newCategoryName) {
    TLVibrationService.vibrate();
    TLValidation.validateNameAndExecute(
      context: context,
      name: newCategoryName,
      validator: TLValidation.validateCategoryName,
      onSuccess: () async {
        // TODO カテゴリーの追加処理
        Navigator.pop(context);
        const TLSingleOptionDialog(title: "カテゴリーが\n追加されました！")
            .show(context: context);
      },
    );
  }
}
