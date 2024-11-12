import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/external/tl_vibration.dart';
import 'package:today_list/styles/styles.dart';
import '../../../model/editing_provider/editing_category_provider.dart';

class AddCategoryDialog extends ConsumerStatefulWidget {
  const AddCategoryDialog({super.key});

  @override
  ConsumerState<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends ConsumerState<AddCategoryDialog> {
  late EdittingCategoryNotifier edittingCategoryNotifier;
  @override
  void initState() {
    super.initState();
    EditingCategory.updateTextEdittingController(editedCategoryTitle: null);
    Future.microtask(() {
      edittingCategoryNotifier = ref.read(edittingCategoryProvider.notifier);
      edittingCategoryNotifier.setInitialValue();
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      edittingCategoryNotifier.disposeValue();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    String enteredCategoryTitle = "";
    // notifier
    final edittingCategoryNotifier =
        ref.read(edittingCategoryProvider.notifier);
    return AlertDialog(
      backgroundColor: tlThemeData.alertColor,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: SizedBox(
                width: 230,
                // 新しいカテゴリー名を入力するTextFormField
                child: TextField(
                  autofocus: true,
                  controller: EditingCategory.categoryTitleInputController,
                  onChanged: (s) {
                    setState(() {
                      enteredCategoryTitle = s;
                    });
                  },
                  cursorColor: tlThemeData.accentColor,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                  decoration: tlInputDecoration(
                      context: context,
                      labelText: "新しいカテゴリー名",
                      icon: null,
                      suffixIcon: null),
                )),
          ),
          // 閉じる 追加するボタン
          OverflowBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              // カテゴリーを作らずにアラートを閉じるボタン
              TextButton(
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("閉じる")),
              // カテゴリーを追加するボタン
              TextButton(
                  style: alertButtonStyle(accentColor: tlThemeData.accentColor),
                  // 入力がなければ非活性
                  onPressed: enteredCategoryTitle.trim().isEmpty
                      ? null
                      : () {
                          // カテゴリー名が入力されているなら追加する
                          edittingCategoryNotifier.completeEditting();
                          TLVibration.vibrate();
                          // to category list
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const TLSingleOptionDialog(
                                    title: "カテゴリーが\n追加されました！", message: null);
                              });
                        },
                  child: const Text("追加"))
            ],
          )
        ],
      ),
    );
  }
}
