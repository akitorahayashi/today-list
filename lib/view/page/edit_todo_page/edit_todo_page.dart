import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/page/edit_todo_page/already_exist/already_exist.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_big_category_dropdown.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_small_category_dropdown.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_today_or_whenever_button.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/todo_title_input_field.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/added_steps_column.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/step_title_input_field.dart';

class EditToDoPage extends HookConsumerWidget {
  final TLWorkspace corrWorkspace;
  final bool ifInToday;
  final String selectedBigCategoryID;
  final String? selectedSmallCategoryID;
  final String? editedToDoTitle;
  final int? indexOfEdittedTodo;

  const EditToDoPage({
    super.key,
    required this.corrWorkspace,
    required this.ifInToday,
    required this.selectedBigCategoryID,
    required this.selectedSmallCategoryID,
    required this.editedToDoTitle,
    required this.indexOfEdittedTodo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    // MARK: - State Management
    final toDoTitleController =
        useTextEditingController(text: editedToDoTitle ?? "");
    final stepTitleController = useTextEditingController();

    final steps = useState<List<TLStep>>([]);
    final bigCategoryID = useState<String>(selectedBigCategoryID);
    final smallCategoryID = useState<String?>(selectedSmallCategoryID);
    final isToday = useState<bool>(ifInToday);
    final editingToDoIndex = useState<int?>(indexOfEdittedTodo);

    final bannerAd = useState<BannerAd?>(null);

    // MARK: - Initialize Editing State
    useEffect(() {
      if (indexOfEdittedTodo == null) {
        steps.value = [];
      } else {
        final String categoryID =
            selectedSmallCategoryID ?? selectedBigCategoryID;
        final TLToDo edittedToDo = corrWorkspace.categoryIDToToDos[categoryID]!
            .getToDos(ifInToday)[indexOfEdittedTodo!];

        steps.value = edittedToDo.steps;
      }
      return null;
    }, const []);

    // MARK: - Ad Loading
    useEffect(() {
      final ad = BannerAd(
        size: AdSize.banner,
        adUnitId: 'TEST_AD_UNIT_ID',
        listener: BannerAdListener(
          onAdLoaded: (ad) => bannerAd.value = ad as BannerAd?,
        ),
        request: const AdRequest(),
      );
      ad.load();
      return null;
    }, []);

    // MARK: - ToDo Operations
    void addToStepList(String stepTitle) {
      final newStep =
          TLStep(id: TLUUIDGenerator.generate(), content: stepTitle);
      steps.value = [...steps.value, newStep];
      stepTitleController.clear();
    }

    Future<void> completeEditing() async {
      if (toDoTitleController.text.trim().isEmpty) return;

      final appStateReducer = ref.read(tlAppStateProvider.notifier);
      final categoryID = smallCategoryID.value ?? bigCategoryID.value;

      final TLToDo newToDo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: corrWorkspace.id,
        categoryID: categoryID,
        content: toDoTitleController.text,
        steps: steps.value,
      );

      if (editingToDoIndex.value == null) {
        // MARK: - Add New ToDo
        appStateReducer.dispatchToDoAction(TLToDoAction.addToDo(
          workspaceID: corrWorkspace.id,
          categoryID: categoryID,
          ifInToday: isToday.value,
          todo: newToDo,
        ));
      } else {
        // MARK: - Update Existing ToDo
        appStateReducer.dispatchToDoAction(TLToDoAction.updateToDo(
          workspaceID: corrWorkspace.id,
          categoryID: categoryID,
          ifInToday: isToday.value,
          index: editingToDoIndex.value!,
          newToDo: newToDo,
        ));
      }

      // Reset fields
      steps.value = [];
      toDoTitleController.clear();
      stepTitleController.clear();
    }

    return Scaffold(
      appBar: TLAppBar(
        context: context,
        pageTitle: "ToDo",
        leadingIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
        trailingIcon: null,
        trailingButtonOnPressed: null,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(color: tlThemeData.backgroundColor),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          ListView(
            children: [
              const SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    SelectBigCategoryDropdown(
                      corrWorkspace: corrWorkspace,
                      bigCategoryID: bigCategoryID.value,
                      onSelected: (newBigID) {
                        smallCategoryID.value = null;
                        bigCategoryID.value = newBigID;
                      },
                    ),
                    SelectSmallCategoryDropdown(
                      corrWorkspace: corrWorkspace,
                      bigCategoryID: bigCategoryID.value,
                      smallCategoryID: smallCategoryID.value,
                      onSelected: (newSmallID) {
                        smallCategoryID.value =
                            newSmallID == noneID ? null : newSmallID;
                      },
                    ),
                    SelectTodayOrWheneverButton(
                      ifInToday: isToday.value,
                      onChanged: (bool newValue) => isToday.value = newValue,
                    ),
                    // The named parameter 'isEditing' is required, but there's no corresponding argument.
                    ToDoTitleInputField(
                      isEditing: editingToDoIndex.value != null,
                      toDoTitleController: toDoTitleController,
                      onCompleteEditing: completeEditing,
                    ),
                    AddedStepsColumn(
                      steps: steps.value,
                      onEditStep: (index) {
                        stepTitleController.text = steps.value[index].content;
                      },
                      onRemoveStep: (index) {
                        steps.value = List<TLStep>.from(steps.value)
                          ..removeAt(index);
                      },
                    ),

                    StepTitleInputField(
                      stepTitleController: stepTitleController,
                      onAddOrEditStep: (title) => addToStepList(title),
                    ),
                    const SizedBox(height: 45),
                  ],
                ),
              ),
              if (bannerAd.value != null) AdWidget(ad: bannerAd.value!),
              AlreadyExist(
                corrWorkspace: corrWorkspace,
                ifInToday: isToday.value,
                bigCategoryID: bigCategoryID.value,
                smallCategoryID: smallCategoryID.value,
              ),
              const SizedBox(height: 250),
            ],
          ),
        ],
      ),
    );
  }
}
