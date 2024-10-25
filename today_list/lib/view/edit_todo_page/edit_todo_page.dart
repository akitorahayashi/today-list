import 'package:flutter/material.dart';
import 'package:today_list/main.dart';
import '../../components/for_ui/tl_sliver_appbar.dart';
import '../../alerts/yes_no_alert.dart';
import '../../model/tl_theme.dart';
import '../../model/todo/tl_step.dart';
import '../../model/todo/tl_category.dart';
import '../../model/workspace/tl_workspace.dart';
import '../../model/external/tl_vibration.dart';
import '../../model/external/tl_ads.dart';
import '../../model/workspace/tl_workspaces.dart';
import '../../crud/for_todo/add_or_edit_todo_action.dart';
import '../../crud/for_todo_category/add_todo_category_alert.dart';
import './components_for_edit/steps_column.dart';
import './components_for_edit/tl_textfield.dart';
import './already_exists/already_exists.dart';
import 'components_for_edit/tl_dropdown_button.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class EditToDoPage extends StatefulWidget {
  final GlobalKey superKey;
  final String toDoTitle;
  final List<TLStep> belogedSteps;
  final bool isInToday;
  final TLCategory bigCategory;
  final TLCategory? smallCategory;
  // editするための変数
  final int? indexOfThisToDoInToDos;
  final String? oldCategoryId;

  // コンストラクタ
  const EditToDoPage({
    required Key key,
    required this.superKey,
    required this.toDoTitle,
    required this.belogedSteps,
    required this.isInToday,
    required this.bigCategory,
    required this.smallCategory,
    required this.indexOfThisToDoInToDos,
    required this.oldCategoryId,
  }) : super(key: key);

  @override
  EditToDoPageState createState() => EditToDoPageState();
}

class EditToDoPageState extends State<EditToDoPage> {
// 広告
  BannerAd? _bannerAd;
// --- textController
  // todo
  final TextEditingController _toDoTitleInputController =
      TextEditingController();
  // steps
  final TextEditingController _stepTitleInputController =
      TextEditingController();
  // category
  final TextEditingController _categoryNameInputController =
      TextEditingController();
  // 入力途中かどうか知る
  bool get toDoTitleIsEntered =>
      _toDoTitleInputController.text.trim().isNotEmpty;
  bool get stepTitleIsEntered =>
      _stepTitleInputController.text.trim().isNotEmpty;
  // カテゴリー
  List<TLStep> _stepsOfThisToDo = [];
  bool _ifInToday = true;
  TLCategory _selectedBigCategory =
      TLWorkspace.currentWorkspace.bigCategories[0];
  TLCategory? _selectedSmallCategory;
  // 編集系
  int? _indexOfThisToDoInToDos;
  // step編集
  int? _edittedStepIndex;

  String get selectedCategoryId =>
      _selectedSmallCategory?.id ?? _selectedBigCategory.id;

// ---

  @override
  void initState() {
    super.initState();
    // 広告を読み込む
    BannerAd(
      adUnitId: TLAds.editPageBannerAdUnitId(isTestMode: kAdTestMode),
      // ignore: prefer_const_constructors
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        },
      ),
    ).load();

    _indexOfThisToDoInToDos = widget.indexOfThisToDoInToDos;
    _toDoTitleInputController.text = widget.toDoTitle;
    for (TLStep step in widget.belogedSteps) {
      _stepsOfThisToDo.add(step);
    }
    _ifInToday = widget.isInToday;
    _selectedBigCategory = widget.bigCategory;
    _selectedSmallCategory = widget.smallCategory;
  }

  @override
  void dispose() {
    super.dispose();
    _toDoTitleInputController.dispose();
    _stepTitleInputController.dispose();
    _categoryNameInputController.dispose();
    _bannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          // 背景色
          Container(
              decoration: BoxDecoration(color: _tlThemeData.backgroundColor),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),

          CustomScrollView(
            slivers: [
              TLSliverAppBar(
                pageTitle: "ToDo",
                leadingButtonOnPressed: () async {
                  if (!toDoTitleIsEntered) {
                    // 元のページに戻る
                    Navigator.pop(context);
                  } else {
                    yesNoAlert(
                        context: context,
                        title: "本当に戻りますか?",
                        message: "ToDoは + から保存できます",
                        yesAction: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
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
                          TLDropDownButton(
                              hintText: _selectedBigCategory.id == noneId
                                  ? "大カテゴリー"
                                  : TLWorkspace.currentWorkspace.bigCategories
                                      .where((oneOfBigCategory) =>
                                          oneOfBigCategory.id ==
                                          _selectedBigCategory.id)
                                      .first
                                      .title,
                              items: [
                                ...TLWorkspace.currentWorkspace.bigCategories,
                                TLCategory(
                                    id: "---bigCategory", title: "新しく作る"),
                              ].map((TLCategory oneOfBigCategory) {
                                return DropdownMenuItem(
                                  value: oneOfBigCategory,
                                  child: Text(
                                    oneOfBigCategory.title,
                                    style: oneOfBigCategory.id ==
                                            _selectedBigCategory.id
                                        ? TextStyle(
                                            color: _tlThemeData.accentColor,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontWeight: FontWeight.bold),
                                  ),
                                );
                              }).toList(),
                              onChanged: (TLCategory? newBigCategory) async {
                                if (newBigCategory != null) {
                                  _selectedSmallCategory = null;
                                  switch (newBigCategory.id) {
                                    case noneId:
                                      _selectedBigCategory = TLWorkspace
                                          .currentWorkspace.bigCategories[0];
                                      break;
                                    case "---bigCategory":
                                      _selectedBigCategory =
                                          await addToDoCategoryAlert(
                                                  context: context,
                                                  categoryNameInputController:
                                                      _categoryNameInputController,
                                                  bigCategoryId: null) ??
                                              TLWorkspace.currentWorkspace
                                                  .bigCategories[0];
                                      break;
                                    default:
                                      _selectedBigCategory = newBigCategory;
                                  }
                                  setState(() {});
                                }
                              }),
                          // --- ビッグカテゴリーを選択する

                          // スモールカテゴリーを選択する
                          TLDropDownButton(
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
                                TLCategory(id: noneId, title: "なし"),
                                ...TLWorkspace.currentWorkspace
                                    .smallCategories[_selectedBigCategory.id]!,
                                if (_selectedBigCategory.id != noneId)
                                  TLCategory(
                                      id: "---smallCategory", title: "新しく作る"),
                              ].map((TLCategory item) {
                                return DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item.title,
                                    style: item.id == _selectedBigCategory.id
                                        ? TextStyle(
                                            color: _tlThemeData.accentColor,
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
                                    case noneId:
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
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: ToggleButtons(
                              // 大きさ
                              constraints: BoxConstraints(
                                minHeight: 35,
                                minWidth:
                                    (MediaQuery.of(context).size.width - 50) /
                                        2,
                              ),
                              // 背景色
                              fillColor:
                                  _tlThemeData.toggleButtonsBackgroundColor,
                              // 文字色
                              selectedColor: _tlThemeData.accentColor,
                              color: _tlThemeData.accentColor,
                              // splashColor
                              splashColor: _tlThemeData
                                  .toggleButtonsBackgroundSplashColor,
                              // 機能
                              isSelected: [_ifInToday, !_ifInToday],
                              renderBorder: true,
                              onPressed: (int index) => setState(() {
                                _ifInToday = index == 0;
                              }),
                              children: const [
                                Text("今日"),
                                Text(" いつでも "),
                              ],
                            ),
                          ),
                          // --- 今日かいつでもか選択する

                          // ToDoのタイトルを入力するTextFormField
                          TLTextfield(
                            isForStep: false,
                            controller: _toDoTitleInputController,
                            onChanged: (_) => setState(() {}),
                            onPressed: !toDoTitleIsEntered
                                ? () => {}
                                : () {
                                    addOrEditToDoAction(
                                      context: context,
                                      indexOfEditedToDo:
                                          _indexOfThisToDoInToDos,
                                      ifInToday: _ifInToday,
                                      bigCategoryOfToDo: _selectedBigCategory,
                                      smallCategoryOfToDo:
                                          _selectedSmallCategory,
                                      toDoInputController:
                                          _toDoTitleInputController,
                                      addedSteps: _stepsOfThisToDo,
                                      oldCategoryId: widget.oldCategoryId,
                                    );
                                    TLVibration.vibrate();
                                    _indexOfThisToDoInToDos = null;
                                    _edittedStepIndex = null;
                                    _stepsOfThisToDo = [];
                                    setState(() {});
                                  },
                          ),

                          // 入力したstepsを表示
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: StepsColumn(
                                stepsOfThisToDo: _stepsOfThisToDo,
                                onTapStepRow: (index) {
                                  _stepTitleInputController.text =
                                      _stepsOfThisToDo[index].title;
                                  _edittedStepIndex = index;
                                  TLVibration.vibrate();
                                  setState(() {});
                                },
                                tapToRemoveStepRow: (index) {
                                  _stepsOfThisToDo.removeAt(index);
                                  _edittedStepIndex = null;
                                  TLVibration.vibrate();
                                }),
                          ),

                          // steps入力のtextFormField
                          TLTextfield(
                            isForStep: true,
                            controller: _stepTitleInputController,
                            onChanged: (_) => setState(() {}),
                            onPressed: !stepTitleIsEntered
                                ? () => {}
                                : () {
                                    if (_edittedStepIndex == null) {
                                      _stepsOfThisToDo.add(TLStep(
                                          id: UniqueKey().toString(),
                                          title:
                                              _stepTitleInputController.text));
                                    } else {
                                      _stepsOfThisToDo
                                          .removeAt(_edittedStepIndex!);
                                      _stepsOfThisToDo.insert(
                                          _edittedStepIndex!,
                                          TLStep(
                                              id: UniqueKey().toString(),
                                              title: _stepTitleInputController
                                                  .text));
                                    }
                                    _stepTitleInputController.clear();
                                    setState(() {});
                                  },
                          ),
                          const SizedBox(
                            height: 45,
                          ),
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
