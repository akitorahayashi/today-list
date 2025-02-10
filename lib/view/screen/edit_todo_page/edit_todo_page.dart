import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/redux/reducer/tl_app_state_reducer.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/util/tl_utils.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/select_big_category_dropdown.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/select_small_category_dropdown.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/select_today_or_whenever_button.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/todo_title_input_field.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/added_steps_column.dart';
import 'package:today_list/view/screen/edit_todo_page/components_for_edit/step_title_input_field.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/component/dialog/for_category/add_category_dialog.dart';
import 'package:today_list/view/screen/edit_todo_page/already_exist/already_exist.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class EditToDoPage extends HookConsumerWidget {
  final bool ifInToday;
  final String selectedBigCategoryID;
  final String? selectedSmallCategoryID;
  final String? editedToDoTitle;
  final int? indexOfEdittedTodo;

  const EditToDoPage({
    super.key,
    required this.ifInToday,
    required this.selectedBigCategoryID,
    required this.selectedSmallCategoryID,
    required this.editedToDoTitle,
    required this.indexOfEdittedTodo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // ---------------------------
    // flutter_hooksでの状態管理
    // ---------------------------
    final toDoTitleController =
        useTextEditingController(text: editedToDoTitle ?? "");
    final stepTitleController = useTextEditingController();

    final steps = useState<List<TLStep>>([]);
    final bigCategoryID = useState<String>(noneID);
    final smallCategoryID = useState<String?>(null);
    final isToday = useState<bool>(true);
    final editingToDoIndex = useState<int?>(null);
    final editingStepIndex = useState<int?>(null);

    final bannerAd = useState<BannerAd?>(null);

    // ---------------------------
    // Notifier的なロジック
    // ---------------------------

    // 初期化する
    void setInitialValue() {
      steps.value = [];
      bigCategoryID.value = noneID;
      smallCategoryID.value = null;
      isToday.value = true;
      editingToDoIndex.value = null;
      editingStepIndex.value = null;
      toDoTitleController.clear();
      stepTitleController.clear();
    }

    // 編集ToDoをセットする
    void setEditedToDo() {
      final appState = ref.read(tlAppStateProvider);
      final TLWorkspace currentWorkspace = appState.getCurrentWorkspace;

      final String corrCategoryID =
          selectedSmallCategoryID ?? selectedBigCategoryID;
      final TLToDo edittedToDo = currentWorkspace
          .categoryIDToToDos[corrCategoryID]!
          .getToDos(ifInToday)[indexOfEdittedTodo!];

      steps.value = edittedToDo.steps;
      bigCategoryID.value = selectedBigCategoryID;
      smallCategoryID.value = selectedSmallCategoryID;
      isToday.value = ifInToday;
      editingToDoIndex.value = indexOfEdittedTodo;
      editingStepIndex.value = null;
    }

    // Stepを追加 or 編集
    void addToStepList(String stepTitle, int? index) {
      final newStep = TLStep(id: TLUtils.generateUniqueId(), title: stepTitle);
      if (index == null) {
        // 新規
        steps.value = [...steps.value, newStep];
      } else {
        // 編集
        final updatedSteps = [...steps.value];
        updatedSteps[index] = newStep;
        steps.value = updatedSteps;
        editingStepIndex.value = null;
      }
    }

    // ToDoを保存 or 編集完了
    Future<void> completeEditing() async {
      if (toDoTitleController.text.trim().isEmpty) return;

      final appState = ref.read(tlAppStateProvider);
      final TLWorkspace currentWorkspace =
          appState.getCurrentWorkspace.copyWith();
      final TLAppStateReducer tlAppStateReducer =
          ref.read(tlAppStateProvider.notifier);

      // 対象カテゴリーID
      final String corrCategoryID =
          smallCategoryID.value ?? bigCategoryID.value;
      // 新規/編集ToDoを生成
      final TLToDo createdToDo = TLToDo(
        id: TLUtils.generateUniqueId(),
        title: toDoTitleController.text,
        steps: steps.value,
      );

      // WorkspaceのToDosを更新
      final updatedCategoryIDToToDos = {...currentWorkspace.categoryIDToToDos};

      final TLToDosInTodayAndWhenever corrToDos =
          updatedCategoryIDToToDos[corrCategoryID]!;
      final List<TLToDo> updatingList =
          isToday.value ? corrToDos.toDosInToday : corrToDos.toDosInWhenever;

      if (editingToDoIndex.value == null) {
        // 新規追加
        updatingList.insert(0, createdToDo);
      } else {
        // 編集
        updatingList[editingToDoIndex.value!] = createdToDo;
      }

      updatedCategoryIDToToDos[corrCategoryID] = corrToDos.copyWith(
        toDosInToday: isToday.value ? updatingList : corrToDos.toDosInToday,
        toDosInWhenever:
            isToday.value ? corrToDos.toDosInWhenever : updatingList,
      );

      final TLWorkspace updatedWorkspace = currentWorkspace.copyWith(
        categoryIDToToDos: updatedCategoryIDToToDos,
      );

      tlAppStateReducer.dispatchWorkspaceAction(
        TLWorkspaceAction.updateCurrentWorkspace(updatedWorkspace),
      );

      // 入力をクリア
      steps.value = [];
      editingToDoIndex.value = null;
      editingStepIndex.value = null;
      toDoTitleController.clear();
      stepTitleController.clear();
    }

    // ---------------------------
    // 初回マウント時のセット
    // ---------------------------
    useEffect(() {
      if (indexOfEdittedTodo == null) {
        setInitialValue();
      } else {
        setEditedToDo();
      }
      return null;
    }, const []);

    // バナー広告の読み込み
    useEffect(() {
      final ad = BannerAd(
        size: AdSize.banner,
        adUnitId: 'TEST_AD_UNIT_ID', // 実際のIDに置き換えてください
        listener: BannerAdListener(
          onAdLoaded: (ad) => bannerAd.value = ad as BannerAd?,
        ),
        request: const AdRequest(),
      );
      ad.load();
      return null;
    }, []);

    return Scaffold(
      appBar: TLAppBar(
        context: context,
        pageTitle: "ToDo",
        leadingButtonOnPressed: () {
          if (toDoTitleController.text.isEmpty) {
            Navigator.pop(context);
          } else {
            showDialog(
              context: context,
              builder: (_) => TLYesNoDialog(
                title: "本当に戻りますか？",
                message: "ToDoは + から保存できます",
                yesAction: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        trailingButtonOnPressed: null,
        trailingIcon: null,
      ),
      body: Stack(
        children: [
          // 背景色
          Container(
            decoration: BoxDecoration(color: tlThemeData.backgroundColor),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ListView(
            children: [
              const SizedBox(height: 10),

              // カード全体
              GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // 1) 大カテゴリー選択
                      SelectBigCategoryDropdown(
                        bigCategoryID: bigCategoryID.value,
                        onSelected: (newBigID) {
                          // 小カテゴリーをリセット
                          smallCategoryID.value = null;
                          editingStepIndex.value = null;
                          if (newBigID == "---createBigCategory") {
                            const AddCategoryDialog().show(context: context);
                          } else {
                            bigCategoryID.value = newBigID;
                          }
                        },
                      ),

                      // 2) 小カテゴリー選択
                      SelectSmallCategoryDropdown(
                        bigCategoryID: bigCategoryID.value,
                        smallCategoryID: smallCategoryID.value,
                        onSelected: (newSmallID) {
                          editingStepIndex.value = null;
                          if (newSmallID == "---createSmallCategory") {
                            AddCategoryDialog().show(context: context);
                          } else {
                            smallCategoryID.value =
                                (newSmallID == noneID) ? null : newSmallID;
                          }
                        },
                      ),

                      // 3) 今日 or いつでも のトグル
                      SelectTodayOrWheneverButton(
                        ifInToday: isToday.value,
                        onChanged: (bool newValue) {
                          isToday.value = newValue;
                        },
                      ),

                      // 4) ToDoタイトル入力欄
                      ToDoTitleInputField(
                        toDoTitleController: toDoTitleController,
                        isEditing: editingToDoIndex.value != null,
                        onCompleteEditing: () async {
                          // 保存処理
                          await completeEditing();
                        },
                      ),

                      // 5) 登録済みStep一覧
                      AddedStepsColumn(
                        steps: steps.value,
                        onEditStep: (index) {
                          stepTitleController.text = steps.value[index].title;
                          editingStepIndex.value = index;
                          TLVibrationService.vibrate();
                        },
                        onRemoveStep: (index) {
                          final copied = [...steps.value];
                          copied.removeAt(index);
                          steps.value = copied;
                          editingStepIndex.value = null;
                          TLVibrationService.vibrate();
                        },
                      ),

                      // 6) Step入力欄
                      StepTitleInputField(
                        stepTitleController: stepTitleController,
                        isEditing: editingStepIndex.value != null,
                        onAddOrEditStep: (title) {
                          addToStepList(title, editingStepIndex.value);
                          TLVibrationService.vibrate();
                          stepTitleController.clear();
                          editingStepIndex.value = null;
                        },
                      ),

                      const SizedBox(height: 45),
                    ],
                  ),
                ),
              ),

              // 広告
              if (bannerAd.value != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: bannerAd.value!.size.width.toDouble(),
                      height: bannerAd.value!.size.height.toDouble(),
                      child: AdWidget(ad: bannerAd.value!),
                    ),
                  ),
                ),

              // 既に存在するToDoを示すウィジェット
              AlreadyExist(
                ifInToday: isToday.value,
                bigCategoryID: bigCategoryID.value,
                smallCategoryID: smallCategoryID.value,
                tapToEditAction: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 250),
            ],
          ),
        ],
      ),
    );
  }
}
