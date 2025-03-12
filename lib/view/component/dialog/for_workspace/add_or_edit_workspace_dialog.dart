import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/common/tl_single_option_dialog.dart';
import 'package:today_list/view/component/dialog/design/tl_dialog.dart';
import 'package:today_list/view/component/dialog/tl_base_dialog_mixin.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_todos_in_today_and_whenever.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/action/workspace_action.dart';
import 'package:today_list/flux/dispatcher/workspace_dispatcher.dart';
import 'package:today_list/flux/store/workspace_store.dart';
import 'package:today_list/service/tl_vibration.dart';
import 'package:today_list/styles.dart';
import 'package:today_list/util/tl_uuid_generator.dart';
import 'package:today_list/util/tl_validation.dart';

class AddOrEditWorkspaceDialog extends ConsumerStatefulWidget
    with TLBaseDialogMixin {
  final String? oldWorkspaceId;
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
    Future.microtask(() async {
      final workspacesAsync = await ref.read(workspacesProvider.future);
      final workspace = workspacesAsync.firstWhere(
        (ws) => ws.id == widget.oldWorkspaceId,
        orElse:
            () =>
                throw Exception(
                  "Workspace ID: ${widget.oldWorkspaceId} not found.",
                ),
      );
      _workspaceNameInputController.text = workspace.name;
    });
  }

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context) {
    final TLThemeConfig themeConfig = TLTheme.of(context);
    final workspacesAsync = ref.watch(workspacesProvider);

    return TLDialog(
      corrThemeConfig: themeConfig,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0, bottom: 32),
            child: _buildDialogTitle(),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: _buildWorkspaceTextField(themeConfig),
          ),
          workspacesAsync.when(
            data:
                (workspaces) =>
                    _buildActionButtons(context, themeConfig, workspaces),
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Error loading workspaces'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // MARK: - UI Components
  Widget _buildDialogTitle() {
    return Text(
      "${(widget.oldWorkspaceId == null ? "Add" : "Edit")} Workspace",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black.withValues(alpha: 0.4),
      ),
    );
  }

  Widget _buildWorkspaceTextField(TLThemeConfig theme) {
    return SizedBox(
      width: 230,
      child: TextField(
        autofocus: true,
        cursorColor: theme.accentColor,
        controller: _workspaceNameInputController,
        style: TextStyle(
          color: Colors.black.withValues(alpha: 0.5),
          fontWeight: FontWeight.w600,
        ),
        decoration: tlInputDecoration(
          context: context,
          labelText: "New Workspace Name",
          icon: null,
          suffixIcon: null,
        ),
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    TLThemeConfig theme,
    List<TLWorkspace> workspaces,
  ) {
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
    BuildContext context,
    List<TLWorkspace> workspaces,
  ) async {
    TLVibrationService.vibrate();
    final workspaceName = _workspaceNameInputController.text;

    await TLValidation.validateNameAndExecute(
      context: context,
      name: workspaceName,
      validator: TLValidation.validateWorkspaceName,
      onSuccess: () async {
        Navigator.pop(context);
        if (widget.oldWorkspaceId == null) {
          final String newWorkspaceID = TLUUIDGenerator.generate();
          await _onAddSuccess(
            context,
            TLWorkspace(
              id: newWorkspaceID,
              name: workspaceName,
              workspaceIDToToDos: {
                newWorkspaceID: TLToDosInTodayAndWhenever(
                  workspaceID: newWorkspaceID,
                  toDosInToday: [],
                  toDosInWhenever: [],
                ),
              },
            ),
          );
        } else {
          await _onEditSuccess(context, workspaces, workspaceName);
        }
      },
    );
  }

  Future<void> _onEditSuccess(
    BuildContext context,
    List<TLWorkspace> workspaces,
    String newName,
  ) async {
    final workspaceIndex = workspaces.indexWhere(
      (ws) => ws.id == widget.oldWorkspaceId,
    );
    if (workspaceIndex == -1) {
      throw Exception("Workspace ID: ${widget.oldWorkspaceId} not found.");
    }

    final TLWorkspace editedWorkspace = workspaces[workspaceIndex].copyWith(
      name: newName,
    );

    await WorkspaceDispatcher.dispatch(
      ref,
      WorkspaceAction.updateWorkspace(editedWorkspace),
    );

    if (context.mounted) {
      const TLSingleOptionDialog(
        title: "Successfully changed!",
      ).show(context: context);
    }
  }

  Future<void> _onAddSuccess(
    BuildContext context,
    TLWorkspace newWorkspace,
  ) async {
    await WorkspaceDispatcher.dispatch(
      ref,
      WorkspaceAction.addWorkspace(newWorkspace),
    );

    if (context.mounted) {
      TLSingleOptionDialog(
        title: newWorkspace.name,
        message: "was successfully added!",
      ).show(context: context);
    }
  }
}
