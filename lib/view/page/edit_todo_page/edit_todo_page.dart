import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/main.dart';
import 'package:today_list/service/tl_ads.dart';
import 'package:today_list/view/component/dialog/common/tl_yes_no_dialog.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_big_category_dropdown.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_small_category_dropdown.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/select_today_or_whenever_button.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/todo_title_input_field.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/added_steps_column.dart';
import 'package:today_list/view/page/edit_todo_page/components_for_edit/step_title_input_field.dart';
import 'package:today_list/view/page/edit_todo_page/already_exist/already_exist.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_uuid_generator.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class EditToDoPage extends HookConsumerWidget {
  final String corrWorkspaceID;
  const EditToDoPage({
    super.key,
    required this.corrWorkspaceID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final corrWorkspace = () {
      final matches = tlAppState.tlWorkspaces
          .where((workspace) => workspace.id == corrWorkspaceID);
      return matches.isNotEmpty ? matches.first : null;
    }()!;

    // MARK: - State Management
    final toDoTitleController = useTextEditingController(text: "");
    final stepTitleController = useTextEditingController();

    final steps = useState<List<TLStep>>([]);
    final bigCategoryID = useState<String>(corrWorkspace.id);
    final smallCategoryID = useState<String?>(null);
    final isToday = useState<bool>(true);

    final bannerAd = useState<BannerAd?>(null);

    // MARK: - Ad Loading
    useEffect(() {
      TLAdsService.loadRewardedAd();

      final ad = BannerAd(
        adUnitId: TLAdsService.editPageBannerAdUnitId(isTestMode: kAdTestMode),
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            bannerAd.value = ad as BannerAd;
          },
          onAdFailedToLoad: (ad, err) {
            print('Failed to load a banner ad: ${err.message}');
            ad.dispose(); // Dispose failed ad immediately
          },
        ),
      );

      ad.load();

      return () {
        TLAdsService.rewardedAd?.dispose();
        bannerAd.value?.dispose();
      };
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
        workspaceID: corrWorkspaceID,
        categoryID: categoryID,
        isInToday: isToday.value,
        content: toDoTitleController.text,
        steps: steps.value,
      );

      // MARK: - Add New ToDo
      appStateReducer.updateState(TLToDoAction.addToDo(
        corrWorkspace: corrWorkspace,
        newToDo: newToDo,
      ));

      // Reset fields
      steps.value = [];
      toDoTitleController.clear();
      stepTitleController.clear();
    }

    return Scaffold(
      appBar: TLAppBar(
        context: context,
        pageTitle: corrWorkspace.name,
        leadingIconData: Icons.arrow_back_ios,
        leadingButtonOnPressed: () {
          if (toDoTitleController.text.isEmpty) {
            Navigator.pop(context);
          } else {
            TLYesNoDialog(
              title: "本当に戻りますか？",
              message: "ToDoは + から保存できます",
              yesAction: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ).show(context: context);
          }
        },
        trailingIconData: null,
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
              const SizedBox(height: 16),
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
                        smallCategoryID.value = newSmallID;
                      },
                    ),
                    SelectTodayOrWheneverButton(
                      ifInToday: isToday.value,
                      onChanged: (bool newValue) => isToday.value = newValue,
                    ),
                    // The named parameter 'isEditing' is required, but there's no corresponding argument.
                    ToDoTitleInputField(
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
