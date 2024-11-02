import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/dialogs/common/single_option_dialog.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../components/for_todo/todos_in_this_category_today/header_for_todos.dart';
import '../../components/for_todo/todos_in_this_category_today/todos_in_this_category_today.dart';
import '../../components/for_ui/today_list_bottom_navbar/center_button_of_bottom_navbar.dart';
import '../../components/for_ui/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import '../../model/tl_theme.dart';
import '../../dialogs/common/yes_no_dialog.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/workspace/tl_workspaces_provider.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/workspace/current_workspace_provider.dart';
import '../edit_todo_page/edit_todo_page.dart';
import '../category_list_page/category_list_page.dart';
import '../setting_page/setting_page.dart';
import './workspace_drawer/workspace_drawer.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  final GlobalKey<ScaffoldState> homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    final TLWorkspace _currentWorkspace = ref.watch(currentWorkspaceProvider);
    final currentWorkspaceNotifier =
        ref.read(currentWorkspaceProvider.notifier);
    final int _currentWorkspaceIndex =
        currentWorkspaceNotifier.currentWorkspaceIndex;

    return Scaffold(
      key: homePageScaffoldKey,
      drawer: WorkspaceDrawer(isContentMode: false),
      body: Stack(children: [
        // 背景色
        Container(color: _tlThemeData.backgroundColor),
        // 本体
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
              pageTitle: _currentWorkspaceIndex == 0
                  ? "Today List"
                  : _currentWorkspace.name,
              // drawerを表示するボタン
              leadingButtonOnPressed: () =>
                  homePageScaffoldKey.currentState!.openDrawer(),
              leadingIcon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              // setting pageへ移動するボタン
              trailingButtonOnPressed: () async {
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return SettingPage();
                }));
              },
              trailingIcon: const Icon(Icons.settings, color: Colors.white),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              if (_currentWorkspace
                  .toDos[_currentWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                const SizedBox(height: 7),
              if (_currentWorkspace
                  .toDos[_currentWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                ToDosInThisCategoryInToday(
                  bigCategoryOfThisToDo: _currentWorkspace.bigCategories[0],
                  // workspace
                  selectedWorkspaceIndex: _currentWorkspaceIndex,
                  selectedWorkspace: _currentWorkspace,
                ),
              // なし以外のbigCategoryの処理
              for (TLCategory bigCategory
                  in _currentWorkspace.bigCategories.sublist(1))
                Column(
                  children: [
                    // big header
                    if (_currentWorkspace
                            .toDos[bigCategory.id]!.toDosInToday.isNotEmpty ||
                        // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                        (_currentWorkspace
                                .smallCategories[bigCategory.id]!.isNotEmpty &&
                            _currentWorkspace.smallCategories[bigCategory.id]!
                                    .indexWhere((smallCategory) =>
                                        _currentWorkspace
                                            .toDos[smallCategory.id]!
                                            .toDosInToday
                                            .isNotEmpty) !=
                                -1))
                      HeaderForToDos(
                          isBigCategory: true, category: bigCategory),
                    // big body
                    if (_currentWorkspace
                        .toDos[bigCategory.id]!.toDosInToday.isNotEmpty)
                      ToDosInThisCategoryInToday(
                        bigCategoryOfThisToDo: bigCategory,
                        // workspace
                        selectedWorkspaceIndex: _currentWorkspaceIndex,
                        selectedWorkspace: _currentWorkspace,
                      ),
                    for (TLCategory smallCategory
                        in _currentWorkspace.smallCategories[bigCategory.id] ??
                            [])
                      if (_currentWorkspace
                          .toDos[smallCategory.id]!.toDosInToday.isNotEmpty)
                        Column(
                          children: [
                            // small header
                            HeaderForToDos(
                                isBigCategory: false, category: smallCategory),
                            // small body
                            ToDosInThisCategoryInToday(
                              bigCategoryOfThisToDo: bigCategory,
                              smallCategoryOfThisToDo: smallCategory,
                              // workspace
                              selectedWorkspaceIndex: _currentWorkspaceIndex,
                              selectedWorkspace: _currentWorkspace,
                            )
                          ],
                        ),
                  ],
                ),
              // なしではない時の処理
              const SizedBox(height: 250)
            ])),
          ],
        ),
        // 今日のチェック済みtodoを全て削除するボタン, カテゴリーリストに移動するボタン
        TodayListBottomNavbar(
          leadingIconData: FontAwesomeIcons.squareCheck,
          //　今日のチェック済みtodoを全て削除するボタン
          leadingButtonOnPressed: () => showDialog(
              context: context,
              builder: ((context) => YesNoDialog(
                    title: "チェック済みToDoを\n削除しますか?",
                    message: null,
                    yesAction: () async {
                      Navigator.pop(context);
                      await currentWorkspaceNotifier
                          .deleteCheckedToDosInTodayInAWorkspace();
                      TLVibration.vibrate();
                      showDialog(
                        context: context,
                        builder: ((context) => SingleOptionDialog(
                              title: "削除が完了しました",
                              message: null,
                              buttonText: "OK",
                            )),
                      );
                    },
                  ))),
          trailingIconData: FontAwesomeIcons.list,
          // カテゴリーリストに移動するボタン
          tralingButtonOnPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CategoryListPage();
            }));
          },
        ),
        // 新たにtodoを追加するボタン
        CenterButtonOfBottomNavBar(
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context) {
              return EditToDoPage(
                toDoTitle: "",
                belogedSteps: const [],
                isInToday: true,
                bigCategory: TLCategory(id: defaultID, title: "なし"),
                smallCategory: null,
                indexOfThisToDoInToDos: null,
                oldCategoryId: null,
              );
            }));
          },
        ),
      ]),
    );
  }
}
