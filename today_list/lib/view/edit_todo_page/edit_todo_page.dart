import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/components/dialog/common/yes_no_dialog.dart';
import 'package:today_list/model/provider/current_tl_workspace_provider.dart';
import 'package:today_list/model/provider/editting_todo_provider.dart';
import 'package:today_list/view/edit_todo_page/components_for_edit/input_field/step_title_input_field.dart';
import 'package:today_list/view/edit_todo_page/components_for_edit/input_field/todo_title_input_field.dart';
import 'package:today_list/view/edit_todo_page/components_for_edit/select_today_or_whenever_button.dart';
import '../../components/common_ui_part/tl_sliver_appbar.dart';
import '../../model/design/tl_theme.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_category.dart';
import '../../model/tl_workspace.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/provider/tl_workspaces_provider.dart';
import 'components_for_edit/added_steps_column.dart';
import './already_exists/already_exists.dart';
import 'components_for_edit/select_category_dropdown/select_big_category_dropdown.dart';

class EditToDoPage extends ConsumerStatefulWidget {
  final bool ifInToday;
  final TLCategory selectedBigCategory;
  final TLCategory? selectedSmallCategory;
  final int? indexOfEdittedTodo;
  const EditToDoPage({
    super.key,
    required this.ifInToday,
    required this.selectedBigCategory,
    required this.selectedSmallCategory,
    required this.indexOfEdittedTodo,
  });

  @override
  ConsumerState<EditToDoPage> createState() => EditToDoPageState();
}

class EditToDoPageState extends ConsumerState<EditToDoPage> {
  TLCategory get _corrCategory =>
      widget.selectedSmallCategory ?? widget.selectedBigCategory;

  @override
  void initState() {
    super.initState();
    // TODO 広告を読み込む

    // provider
    final TLWorkspace currentWorkspace = ref.read(currentTLWorkspaceProvider);
    // notifier
    final EditingToDoNotifier edittingToDoNotifier =
        ref.read(edittingToDoProvider.notifier);
    // _edittingToDoNotifierの値を初期化する
    if (widget.indexOfEdittedTodo == null) {
      edittingToDoNotifier.setInitialValue();
    } else {
      // すでにあるTLToDoを経集する
      edittingToDoNotifier.setEditedToDo(
        ifInToday: widget.ifInToday,
        selectedBigCategory: widget.selectedBigCategory,
        selectedSmallCategory: widget.selectedSmallCategory,
        indexOfEditingToDo: widget.indexOfEdittedTodo!,
      );
    }
  }

  @override
  void dispose() {
    ref.read(edittingToDoProvider.notifier).disposeValue();
    // TODO 広告を破棄する
    // _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final EditingToDoNotifier edittingToDoNotifier =
        ref.read(edittingToDoProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          // 背景色
          Container(
              decoration: BoxDecoration(color: tlThemeData.backgroundColor),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),

          CustomScrollView(
            slivers: [
              TLSliverAppBar(
                pageTitle: "ToDo",
                leadingButtonOnPressed: () async {
                  if (edittingToDoNotifier
                      .toDoTitleInputController.text.isEmpty) {
                    // 元のページに戻る
                    Navigator.pop(context);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) => YesNoDialog(
                            title: "本当に戻りますか？",
                            message: "ToDoは + から保存できます",
                            yesAction: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }));
                  }
                },
                leadingIcon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                trailingButtonOnPressed: null,
                trailingIcon: null,
                // trailingButtonOnPressed: adIsClosed
                //     ? null
                //     : () async {
                //         await Navigator.push(context,
                //             MaterialPageRoute(builder: (context) {
                //           return ProPage(
                //             key: proPageKey,
                //           );
                //         }));
                //         editToDoPageKey.currentState?.setState(() {});
                //       },
                // trailingIcon: adIsClosed
                //     ? null
                //     : isDevelopperMode
                //         ? const Icon(
                //             Icons.construction,
                //             color: Colors.white,
                //           )
                //         : purchase.havePurchased
                //             ? const Icon(
                //                 FontAwesomeIcons.crown,
                //                 color: Colors.white,
                //                 size: 17,
                //               )
                //             : Transform.rotate(
                //                 angle: 3.14,
                //                 child: const Icon(
                //                   Icons.auto_awesome,
                //                   color: Colors.white,
                //                 ))
              ),
              // 入力部分の本体
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 10),
                    // 入力部分
                    GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(children: [
                          // ビッグカテゴリーを選択してsmallCategory選択のためのdropdownを更新する
                          SelectBigCategoryDropDown(
                              hintText: 
                              items: ,
                              onChanged: ),
                          // --- ビッグカテゴリーを選択する

                          // スモールカテゴリーを選択する
                          SelectBigCategoryDropDown(
                              hintText: _selectedSmallCategory == null
                                  ? "小カテゴリー"
                                  : TLWorkspace.currentWorkspace
                                      .smallCategories[_selectedBigCategory.id]!
                                      .where((oneOfSmallCategory) =>
                                          oneOfSmallCategory.id ==
                                          _selectedSmallCategory!.id)
                                      .first
                                      .title,
                              items: [
                                TLCategory(id: noneID, title: "なし"),
                                ...TLWorkspace.currentWorkspace
                                    .smallCategories[_selectedBigCategory.id]!,
                                if (_selectedBigCategory.id != noneID)
                                  TLCategory(
                                      id: "---smallCategory", title: "新しく作る"),
                              ].map((TLCategory item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.title,
                                    style: item.id == _selectedBigCategory.id
                                        ? TextStyle(
                                            color: tlThemeData.accentColor,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                              onChanged: (TLCategory? newSmallCategory) async {
                                if (newSmallCategory != null) {
                                  switch (newSmallCategory.id) {
                                    case noneID:
                                      _selectedSmallCategory = null;
                                      break;
                                    case "---smallCategory":
                                      _selectedSmallCategory =
                                          await addToDoCategoryAlert(
                                              context: context,
                                              categoryNameInputController:
                                                  _categoryNameInputController,
                                              bigCategoryId:
                                                  _selectedBigCategory.id);
                                      break;
                                    default:
                                      _selectedSmallCategory = newSmallCategory;
                                  }
                                  setState(() {});
                                }
                              }),
                          // --- スモールカテゴリーを選択する

                          // 一列目 今日かいつでもか選択する
                          const SelectTodayOrWheneverButton(),
                          // --- 今日かいつでもか選択する

                          // ToDoのタイトルを入力するTextFormField
                          const ToDoTitleInputField(),

                          // 入力したstepsを表示
                          const AddedStepsColumn(),

                          // steps入力のtextFormField
                          const StepTitleInputField(),

                          const SizedBox(height: 45),
                        ]),
                      ),
                    ),
                    // 広告
                    if (_bannerAd != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: SizedBox(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ),
                        ),
                      ),
                    // already exists
                    AlreadyExists(
                        ifInToday: _ifInToday,
                        bigCategoryOfThisToDo: _selectedBigCategory,
                        smallCategoryOfThisToDo: _selectedSmallCategory,
                        tapToEditAction: () async {
                          Navigator.pop(context);
                        }),
                    const SizedBox(
                      height: 250,
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
