import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../components/common_ui_part/today_list_bottom_navbar/center_button_of_bottom_navbar.dart';
import '../../components/common_ui_part/today_list_bottom_navbar/today_list_bottom_navbar.dart';
import '../../components/dialog/common/single_option_dialog.dart';
import '../../components/dialog/common/yes_no_dialog.dart';
import '../../components/common_ui_part/tl_sliver_appbar.dart';
import './todos_in_this_category_today/header_for_todos.dart';
import './todos_in_this_category_today/todos_in_this_category_in_today.dart';
import '../../model/design/tl_theme.dart';
import '../../model/tl_workspace.dart';
import '../../model/todo/tl_category.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/provider/current_tl_workspace_provider.dart';
import '../edit_todo_page/edit_todo_page.dart';
import '../category_list_page/category_list_page.dart';
import '../setting_page/setting_page.dart';
import './workspace_drawer/workspace_drawer.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _accetColorIsChanged = false;
  final GlobalKey<ScaffoldState> homePageScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // 画面の描画が終わったタイミングで処理
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_accetColorIsChanged) {
        _accetColorIsChanged = true;
        print("accetColor is changed");
        setState(() {});
        FlutterNativeSplash.remove();
      }
      // if (settingData.isFirstEntry) {
      //   Navigator.push(context, MaterialPageRoute(builder: (context) {
      //     return const ShowTutorialPage();
      //   }));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final TLWorkspace currentTLWorkspace =
        ref.watch(currentTLWorkspaceProvider);
    final currentTLWorkspaceNotifier =
        ref.read(currentTLWorkspaceProvider.notifier);
    final int currentTLWorkspaceIndex =
        currentTLWorkspaceNotifier.currentTLWorkspaceIndex;

    return Scaffold(
      key: homePageScaffoldKey,
      drawer: const TLWorkspaceDrawer(isContentMode: false),
      body: Stack(children: [
        // 背景色
        Container(color: tlThemeData.backgroundColor),
        // 本体
        CustomScrollView(
          slivers: [
            TLSliverAppBar(
              pageTitle: currentTLWorkspaceIndex == 0
                  ? "Today List"
                  : currentTLWorkspace.name,
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
                  return const SettingPage();
                }));
              },
              trailingIcon: const Icon(Icons.settings, color: Colors.white),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 10,
              ),
              if (currentTLWorkspace
                  .toDos[currentTLWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                const SizedBox(height: 7),
              if (currentTLWorkspace
                  .toDos[currentTLWorkspace.bigCategories[0].id]!
                  .toDosInToday
                  .isNotEmpty)
                ToDosInThisCategoryInToday(
                  bigCategoryOfThisToDo: currentTLWorkspace.bigCategories[0],
                  smallCategoryOfThisToDo: null,
                ),
              // なし以外のbigCategoryの処理
              for (TLCategory bigCategory
                  in currentTLWorkspace.bigCategories.sublist(1))
                Column(
                  children: [
                    // big header
                    if (currentTLWorkspace
                            .toDos[bigCategory.id]!.toDosInToday.isNotEmpty ||
                        // そのsmallCategoryがToDoを持っていたら、bigHeaderを表示
                        (currentTLWorkspace
                                .smallCategories[bigCategory.id]!.isNotEmpty &&
                            currentTLWorkspace.smallCategories[bigCategory.id]!
                                    .indexWhere((smallCategory) =>
                                        currentTLWorkspace
                                            .toDos[smallCategory.id]!
                                            .toDosInToday
                                            .isNotEmpty) !=
                                -1))
                      CategoryHeaderForToDos(
                          isBigCategory: true, corrCategory: bigCategory),
                    // big body
                    if (currentTLWorkspace
                        .toDos[bigCategory.id]!.toDosInToday.isNotEmpty)
                      ToDosInThisCategoryInToday(
                        bigCategoryOfThisToDo: bigCategory,
                        smallCategoryOfThisToDo: null,
                      ),
                    for (TLCategory smallCategory
                        in currentTLWorkspace.smallCategories[bigCategory.id] ??
                            [])
                      if (currentTLWorkspace
                          .toDos[smallCategory.id]!.toDosInToday.isNotEmpty)
                        Column(
                          children: [
                            // small header
                            CategoryHeaderForToDos(
                                isBigCategory: false,
                                corrCategory: smallCategory),
                            // small body
                            ToDosInThisCategoryInToday(
                              bigCategoryOfThisToDo: bigCategory,
                              smallCategoryOfThisToDo: smallCategory,
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
                      await currentTLWorkspaceNotifier
                          .deleteCheckedToDosInTodayInCurrentWorkspace();
                      TLVibration.vibrate();
                      showDialog(
                        context: context,
                        builder: ((context) => SingleOptionDialog(
                              title: "削除が完了しました！",
                              message: null,
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
                ifInToday: true,
                selectedBigCategory: currentTLWorkspace.bigCategories[0],
                selectedSmallCategory: null,
                indexOfEdittedTodo: null,
              );
            }));
          },
        ),
      ]),
    );
  }
}
