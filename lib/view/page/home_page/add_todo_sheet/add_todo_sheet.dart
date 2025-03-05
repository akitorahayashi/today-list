import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_step.dart';
import 'package:today_list/model/todo/tl_todo.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_todo_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/view/component/for_edit/added_steps_column.dart';
import 'package:today_list/view/component/for_edit/select_today_or_whenever_button.dart';
import 'package:today_list/view/component/for_edit/step_title_input_field.dart';
import 'package:today_list/view/component/for_edit/todo_title_input_field.dart';

class AddToDoSheet extends HookConsumerWidget {
  final String workspaceID;

  const AddToDoSheet({
    super.key,
    required this.workspaceID,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final tlAppState = ref.watch(tlAppStateProvider);
    final TLWorkspace corrWorkspace = () {
      final matches = tlAppState.tlWorkspaces
          .where((workspace) => workspace.id == workspaceID);
      return matches.isNotEmpty ? matches.first : tlAppState.tlWorkspaces.first;
    }();

    // MARK: - State Management
    final toDoTitleController = useTextEditingController(text: "");
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

      final appStateReducer = ref.read(tlAppStateProvider.notifier);

      final TLToDo newToDo = TLToDo(
        id: TLUUIDGenerator.generate(),
        workspaceID: corrWorkspace.id,
        isInToday: isToday.value,
        content: toDoTitleController.text,
        steps: steps.value,
      );

      // MARK: - Add New ToDo
      await appStateReducer.updateState(TLToDoAction.addToDo(
        corrWorkspace: corrWorkspace,
        newToDo: newToDo,
      ));

      // Reset fields
      steps.value = [];
      toDoTitleController.clear();
      stepTitleController.clear();

      // Close sheet
      Navigator.pop(context);
    }

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: tlThemeConfig.whiteBasedColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Sheet handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const SizedBox(height: 20),

              // Workspace name
              Text(
                corrWorkspace.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: tlThemeConfig.accentColor,
                ),
              ),
              const SizedBox(height: 16),

              // Today or Whenever selector
              SelectTodayOrWheneverButton(
                ifInToday: isToday.value,
                onChanged: (bool newValue) => isToday.value = newValue,
              ),
              const SizedBox(height: 16),

              // ToDo title input
              ToDoTitleInputField(
                toDoTitleController: toDoTitleController,
                onCompleteEditing: completeEditing,
              ),

              // Added steps
              AddedStepsColumn(
                steps: steps.value,
                onEditStep: (index) {
                  stepTitleController.text = steps.value[index].content;
                },
                onRemoveStep: (index) {
                  steps.value = List<TLStep>.from(steps.value)..removeAt(index);
                },
              ),

              // Step input
              StepTitleInputField(
                stepTitleController: stepTitleController,
                onAddOrEditStep: (title) => addToStepList(title),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
