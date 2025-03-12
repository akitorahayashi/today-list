import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/flux/action/todo_action.dart';
import 'package:today_list/flux/dispatcher/todo_dispatcher.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/view/component/common_ui_part/tl_appbar.dart';
import 'package:today_list/view/component/snack_bar/snack_bar_to_notify_todo_or_step_is_edited.dart';
import 'package:today_list/view/page/add_todo_page/already_exist/already_exist.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/added_steps_column.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/select_today_or_whenever_button.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/step_title_input_field.dart';
import 'package:today_list/view/page/add_todo_page/components_for_edit/todo_title_input_field.dart';

class AddToDoPage extends HookConsumerWidget {
  final String workspaceID;

  const AddToDoPage({
    super.key,
    required this.workspaceID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tlThemeConfig = TLTheme.of(context);
    final workspacesAsync = ref.watch(workspacesProvider);

    // ワークスペースの取得
    final corrWorkspace = workspacesAsync.when(
      data: (workspaces) {
        final matches =
            workspaces.where((workspace) => workspace.id == workspaceID);
        return matches.isNotEmpty ? matches.first : workspaces.first;
      },
      loading: () => null,
      error: (_, __) => null,
    );

    // ワークスペースが読み込まれていない場合はローディング表示
    if (corrWorkspace == null) {
      return Scaffold(
        backgroundColor: tlThemeConfig.backgroundColor,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // スクロール位置を監視するためのコントローラー
    final scrollController = useScrollController();
    // AppBarの透明度を管理するState
    final appBarOpacity = useState<double>(1.0);

    // キーボードの表示状態を監視
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    // カードの下部位置を設定（キーボード表示時は4、非表示時は28）
    final cardBottomPosition = isKeyboardVisible ? 4.0 : 28.0;

    // スクロール位置に応じてAppBarの透明度を変更
    useEffect(() {
      void listener() {
        // スクロール位置が一定以上になったら透明度を下げる
        if (scrollController.offset > 20 && appBarOpacity.value != 0.3) {
          appBarOpacity.value = 0.3;
        } else if (scrollController.offset <= 20 &&
            appBarOpacity.value != 1.0) {
          appBarOpacity.value = 1.0;
        }
      }

      scrollController.addListener(listener);
      return () => scrollController.removeListener(listener);
    }, [scrollController]);

    // MARK: - State Management
    final toDoTitleController = useTextEditingController();
    final stepTitleController = useTextEditingController();
    final steps = useState<List<TLStep>>([]);
    final isToday = useState<bool>(true);

    // MARK: - ToDo Operations
    void addToStepList(String stepTitle) {
      final newStep =
          TLStep(id: TLUUIDGenerator.generate(), content: stepTitle);
      steps.value = [...steps.value, newStep];
      stepTitleController.clear();
    }

    Future<void> completeEditing() async {
      if (toDoTitleController.text.trim().isEmpty) return;

      // 新規ToDoを作成
      final TLToDo newToDo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: corrWorkspace.id,
        isInToday: isToday.value,
        content: toDoTitleController.text,
        steps: steps.value,
      );

      // MARK: - Add New ToDo using Flux
      TodoDispatcher.dispatch(
        ref,
        TodoAction.addTodo(
          workspace: corrWorkspace,
          todo: newToDo,
        ),
      );

      // スナックバー表示
      if (context.mounted) {
        NotifyTodoOrStepIsEditedSnackBar.show(
          context: context,
          newTitle: toDoTitleController.text,
          newCheckedState: false,
          isToDoCard: true,
          quickChangeToToday: null,
        );
      }

      // Reset fields
      steps.value = [];
      toDoTitleController.clear();
      stepTitleController.clear();

      TLVibrationService.vibrate();
    }

    return Scaffold(
      backgroundColor: tlThemeConfig.backgroundColor,
      extendBodyBehindAppBar: true, // AppBarの背後にコンテンツを表示
      appBar: TLAppBar(
        context: context,
        pageTitle: corrWorkspace.name,
        leadingButtonOnPressed: () => Navigator.pop(context),
        leadingIconData: Icons.arrow_back_ios_new,
        trailingButtonOnPressed: null,
        trailingIconData: null,
        opacity: appBarOpacity.value, // 透明度を設定
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              controller: scrollController, // スクロールコントローラーを設定
              padding: EdgeInsets.only(
                  top: kToolbarHeight +
                      MediaQuery.of(context)
                          .padding
                          .top), // AppBarの高さ分のパディングを追加
              children: [
                // 既存のToDoリスト表示
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AlreadyExist(
                    corrWorkspace: corrWorkspace,
                  ),
                ),

                const SizedBox(height: 200),
              ],
            ),
          ),
          // ToDoを追加するカード
          AnimatedPositioned(
            right: 0,
            left: 0,
            bottom: cardBottomPosition, // キーボード表示状態に応じて位置を変更
            duration: const Duration(milliseconds: 300), // アニメーション時間
            curve: Curves.easeInOut, // アニメーションカーブ
            child: Card(
              color: tlThemeConfig.whiteBasedColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Today/Whenever 選択ボタン
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SelectTodayOrWheneverButton(
                        ifInToday: isToday.value,
                        onChanged: (value) => isToday.value = value,
                      ),
                    ),

                    // ToDo入力フィールド
                    ToDoTitleInputField(
                      toDoTitleController: toDoTitleController,
                      onCompleteEditing: completeEditing,
                    ),

                    // 追加済みのステップ一覧
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: AddedStepsColumn(
                        steps: steps.value,
                        onEditStep: (index) {
                          stepTitleController.text = steps.value[index].content;
                        },
                        onRemoveStep: (index) {
                          steps.value = List<TLStep>.from(steps.value)
                            ..removeAt(index);
                        },
                      ),
                    ),

                    // ステップ入力フィールド
                    StepTitleInputField(
                      stepTitleController: stepTitleController,
                      onAddOrEditStep: (title) => addToStepList(title),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
