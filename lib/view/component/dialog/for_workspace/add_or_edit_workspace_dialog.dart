import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/tl_app_state.dart';
import 'package:today_list/model/todo/tl_todo_category.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/action/tl_app_state_action.dart';
import 'package:today_list/redux/action/tl_workspace_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/util/tl_validation.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';

class AddOrEditWorkspaceDialog extends ConsumerStatefulWidget
    with TLBaseDialogMixin {
  final String? oldWorkspaceId; // IDベースに変更
  const AddOrEditWorkspaceDialog({super.key, required this.oldWorkspaceId});

  @override
  ConsumerState<AddOrEditWorkspaceDialog> createState() =>
      _AddOrEditWorkspaceDialogState();
}

class _AddOrEditWorkspaceDialogState
    extends ConsumerState<AddOrEditWorkspaceDialog> {
  final TextEditingController _workspaceNameInputController =
      TextEditingController();

  // MARK: - Lifecycle (Init & Dispose)
  @override
  void initState() {
    super.initState();
    _initializeWorkspaceName();
  }

  @override
  void dispose() {
    _workspaceNameInputController.dispose();
    super.dispose();
  }

  // MARK: - Initialization
  void _initializeWorkspaceName() {
    if (widget.oldWorkspaceId == null) return;
    Future.microtask(() {
      final List<TLWorkspace> workspaces =
          ref.read(tlAppStateProvider).tlWorkspaces;
      final workspace = workspaces.firstWhere(
        (ws) => ws.id == widget.oldWorkspaceId,
        orElse: () => throw Exception(
            "Workspace ID: ${widget.oldWorkspaceId} not found."),
      );
      _workspaceNameInputController.text = workspace.name;
    });
  }

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig theme = TLTheme.of(context);
    final List<TLWorkspace> workspaces = ref.watch(
      tlAppStateProvider.select((state) => state.tlWorkspaces),
    );

    return Dialog(
      backgroundColor: theme.alertBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDialogTitle(),
          _buildWorkspaceTextField(theme),
          _buildActionButtons(context, theme, workspaces),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // MARK: - UI Components
  Widget _buildDialogTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Text(
        "Workspace",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildWorkspaceTextField(TLThemeConfig theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: SizedBox(
        width: 230,
        child: TextField(
          autofocus: true,
          cursorColor: theme.accentColor,
          controller: _workspaceNameInputController,
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w600,
          ),
          decoration: tlInputDecoration(
            context: context,
            labelText: "New Workspace Name",
            icon: null,
            suffixIcon: null,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, TLThemeConfig theme, List<TLWorkspace> workspaces) {
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
        TextButton(
          style: alertButtonStyle(accentColor: theme.accentColor),
          onPressed: () async => _handleSave(context, workspaces),
          child: Text(widget.oldWorkspaceId == null ? "Add" : "Edit"),
        ),
      ],
    );
  }

  // MARK: - Actions
  Future<void> _handleSave(
      BuildContext context, List<TLWorkspace> workspaces) async {
    TLVibrationService.vibrate();
    final workspaceName = _workspaceNameInputController.text;

    await TLValidation.validateNameAndExecute(
      context: context,
      name: workspaceName,
      validator: TLValidation.validateWorkspaceName,
      onSuccess: () async {
        Navigator.pop(context);
        if (widget.oldWorkspaceId == null) {
          await _onAddSuccess(context, workspaceName);
        } else {
          await _onEditSuccess(context, workspaces, workspaceName);
        }
      },
    );
  }

  Future<void> _onEditSuccess(BuildContext context,
      List<TLWorkspace> workspaces, String newName) async {
    final tlAppStateReducer = ref.read(tlAppStateProvider.notifier);

    final workspaceIndex =
        workspaces.indexWhere((ws) => ws.id == widget.oldWorkspaceId);
    if (workspaceIndex == -1) {
      throw Exception("Workspace ID: ${widget.oldWorkspaceId} not found.");
    }

    final TLWorkspace editedWorkspace =
        workspaces[workspaceIndex].copyWith(name: newName);
    final updatedWorkspaces = List<TLWorkspace>.from(workspaces);
    updatedWorkspaces[workspaceIndex] = editedWorkspace;

    tlAppStateReducer.dispatch(
      TLAppStateAction.saveWorkspaceList(updatedWorkspaces),
    );
    const TLSingleOptionDialog(title: "Successfully changed!")
        .show(context: context);
  }

  Future<void> _onAddSuccess(BuildContext context, String workspaceName) async {
    final createdWorkspace = TLWorkspace(
      id: UniqueKey().toString(),
      name: workspaceName,
      bigCategories: [
        const TLToDoCategory(
            id: noneID, parentBigCategoryID: null, name: "None")
      ],
      smallCategories: {noneID: []},
      categoryIDToToDos: {
        noneID: const TLToDosInTodayAndWhenever(
            toDosInToday: [], toDosInWhenever: [])
      },
    );

    ref.read(tlAppStateProvider.notifier).dispatch(
          TLWorkspaceAction.addWorkspace(createdWorkspace),
        );
    TLSingleOptionDialog(
            title: workspaceName, message: "was successfully added!")
        .show(context: context);
  }
}
