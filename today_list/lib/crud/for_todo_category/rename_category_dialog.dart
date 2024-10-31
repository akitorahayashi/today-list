import 'package:flutter/material.dart';
import '../../alerts/simple_alert.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/external/tl_vibration.dart';
import '../../constants/styles.dart';

Widget renameCategoryDialog({
  required BuildContext context,
  required int indexOfBigCategory,
  required int? indexOfSmallCategory,
}) {
  final TLThemeData _tlThemeData = TLTheme.of(context);
  final TLCategory oldCategory = indexOfSmallCategory == null
      ? TLWorkspace.currentWorkspace.bigCategories[indexOfBigCategory]
      : TLWorkspace.currentWorkspace.smallCategories[TLWorkspace
          .currentWorkspace
          .bigCategories[indexOfBigCategory]
          .id]![indexOfSmallCategory];
  // textFieldに改名する準備をする
  String? newCategoryName = oldCategory.title;
  TextEditingController controllerForRename =
      TextEditingController(text: oldCategory.title);
  return AlertDialog(
    backgroundColor: _tlThemeData.alertColor,
    title: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 3.0),
          child: Text("元のカテゴリー名",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.w600)),
        ),
        Text(
          oldCategory.title,
          style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.w600),
        )
      ],
    ),
    content: SizedBox(
      height: 160,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 新しいカテゴリー名を入力するTextFormField
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: SizedBox(
                width: 230,
                child: TextFormField(
                  autofocus: true,
                  controller: controllerForRename,
                  cursorColor: _tlThemeData.accentColor,
                  onChanged: (String? enteredCategoryName) {
                    if (enteredCategoryName != null &&
                        enteredCategoryName.trim() != "") {
                      newCategoryName = enteredCategoryName;
                    } else {
                      newCategoryName = null;
                    }
                  },
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontWeight: FontWeight.w600),
                  decoration: tlInputDecoration(
                      context: context,
                      labelText: "新しいカテゴリー名",
                      icon: null,
                      suffixIcon: null),
                ),
              ),
            ),
            // 戻す、完了ボタン
            OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                // 戻すボタン
                TextButton(
                  onPressed: () {
                    newCategoryName = null;
                    Navigator.pop(context);
                  },
                  child: Text(
                    "戻す",
                    style: TextStyle(color: _tlThemeData.accentColor),
                  ),
                ),
                // 完了ボタン
                TextButton(
                  // なかったらdisable
                  onPressed: () {
                    if (newCategoryName == null) {
                      Navigator.pop(context);
                    } else {
                      // todo category
                      if (indexOfSmallCategory != null) {
                        // smallの場合、タイトルを変える
                        TLWorkspace
                            .currentWorkspace
                            .smallCategories[TLWorkspace
                                .currentWorkspace
                                .bigCategories[indexOfBigCategory]
                                .id]![indexOfSmallCategory]
                            .title = newCategoryName!;
                        TLCategory.saveSmallCategories();
                      } else {
                        // bigCategoryを更新
                        TLWorkspace
                            .currentWorkspace
                            .bigCategories[indexOfBigCategory]
                            .title = newCategoryName!;
                        TLCategory.saveBigCategories();
                      }
                      // alert → all page → category list
                      Navigator.pop(context);
                      Navigator.pop(context);
                      TLVibration.vibrate();
                      simpleAlert(
                          context: context,
                          corrThemeData: _tlThemeData,
                          title: "変更することに\n成功しました!",
                          message: null,
                          buttonText: "OK");
                    }
                  },
                  child: Text(
                    "完了",
                    style: TextStyle(color: _tlThemeData.accentColor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
