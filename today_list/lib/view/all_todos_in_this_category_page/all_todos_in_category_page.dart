import 'package:flutter/material.dart';
import 'package:today_list/alerts/common/simple_alert.dart';
import './todo_block_in_today_or_whenever.dart';
import './edit_category_card.dart';
import '../../alerts/common/yes_no_alert.dart';
import '../../constants/theme.dart';
import '../../constants/global_keys.dart';
import '../../model/tl_category.dart';
import '../../model/workspace/workspace.dart';
import '../../model/user/setting_data.dart';
import '../../model/externals/tl_vibration.dart';
import '../../model/workspace/id_to_jsonworkspaceList.dart';
import '../../components/for_ui/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../crud/for_todo/delete_all_checked_todo_in_todos.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllToDosInThisCategoryPage extends StatefulWidget {
  final int indexOfBigCategory;
  final int? indexOfSmallCategory;

  const AllToDosInThisCategoryPage({
    required Key key,
    required this.indexOfBigCategory,
    this.indexOfSmallCategory,
  }) : super(key: key);

  @override
  AllToDosInThisCategoryPageState createState() =>
      AllToDosInThisCategoryPageState();
}

class AllToDosInThisCategoryPageState
    extends State<AllToDosInThisCategoryPage> {
  TLCategory get _bigCategoryOfThisPage =>
      currentWorkspace.bigCategories[widget.indexOfBigCategory];
  TLCategory? get _smallCategoryOfThisPage =>
      widget.indexOfSmallCategory != null
          ? currentWorkspace.smallCategories[_bigCategoryOfThisPage.id]![
              widget.indexOfSmallCategory!]
          : null;
  // このページのカテゴリー
  TLCategory get _categoryOfThisPage =>
      _smallCategoryOfThisPage ?? _bigCategoryOfThisPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // 背景色
        Container(
            decoration: BoxDecoration(
                color: theme[settingData.selectedTheme]!.backgroundColor),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height),
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
                titleFontSize: 15,
                titleSpacing: 0.5,
                pageTitle: _categoryOfThisPage.title,
                // カテゴリーリストに戻るボタン
                leadingButtonOnPressed: () => Navigator.pop(context),
                leadingIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Transform.rotate(
                    angle: 3.14 * 3 / 2,
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                // カテゴリーを編集するカードを表示するボタン
                trailingButtonOnPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return EditCatedgoryCard(
                            indexOfBigCategory: widget.indexOfBigCategory,
                            indexOfSmallCategory: widget.indexOfSmallCategory);
                      });
                },
                trailingIcon: _bigCategoryOfThisPage.id == noneId
                    ? null
                    : const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 24,
                      )),
            // ToDoを表示するSliverList
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              // 「今日」のブロック
              ToDoBlockInTodayOrWhenever(
                ifInToday: true,
                bigCategoryThisPage:
                    currentWorkspace.bigCategories[widget.indexOfBigCategory],
                smallCategoryThisPage: widget.indexOfSmallCategory == null
                    ? null
                    : _categoryOfThisPage,
              ),
              // 「いつでも」のブロック
              ToDoBlockInTodayOrWhenever(
                ifInToday: false,
                bigCategoryThisPage:
                    currentWorkspace.bigCategories[widget.indexOfBigCategory],
                smallCategoryThisPage: widget.indexOfSmallCategory == null
                    ? null
                    : _categoryOfThisPage,
              ),
              const SizedBox(height: 250)
            ])),
          ],
        ),
        // このカテゴリーに含まれるチェック済みtodoを全て削除するボタン, ホームに戻るボタン
        TodayListBottomNavbar(
          // このカテゴリーに含まれるチェック済みtodoを全て削除するボタン
          leadingIconData: FontAwesomeIcons.squareCheck,
          leadingButtonOnPressed: () {
            yesNoAlert(
                context: context,
                title: "チェック済みToDoを\n削除しますか?",
                message: null,
                yesAction: () {
                  Navigator.pop(context);
                  // Todo.dartの方で全部書いてある
                  deleteAllCheckedToDosInThisToDos(
                      onlyToday: false,
                      selectedToDos:
                          currentWorkspace.toDos[_categoryOfThisPage.id]!);
                  allToDosInCategoryPageKey.currentState?.setState(() {});
                  categoryListPageKey.currentState?.setState(() {});
                  TLVibration.vibrate();
                  Workspace.saveSelectedWorkspace(
                    selectedWorkspaceCategoryId: currentWorkspaceCategoryId,
                    selectedWorkspaceIndex: currentWorkspaceIndex,
                    selectedWorkspace: currentWorkspace,
                  );
                  simpleAlert(
                      context: context,
                      title: "削除が完了しました！",
                      message: null,
                      buttonText: "OK");
                });
          },
          // ホームに戻るボタン
          trailingIconData: FontAwesomeIcons.houseChimney,
          tralingButtonOnPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
        // todoを追加するカードを表示するボタン
        // CenterButtonOfBottomNavBar(ons
      ]),
    );
  }
}
