import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/for_workspace/select_edit_workspace_method_dialog.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/flux/store/current_workspace_store.dart';

class WorkspaceCard extends ConsumerWidget {
  final TLWorkspace corrWorkspace;

  const WorkspaceCard({super.key, required this.corrWorkspace});

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final currentWorkspaceIdAsync = ref.watch(currentWorkspaceIdProvider);
    final bool isCurrentWorkspace = currentWorkspaceIdAsync.maybeWhen(
      data: (id) => corrWorkspace.id == id,
      orElse: () => false,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
        child: GestureDetector(
          onTap: () => _handleWorkspaceSelection(context, isCurrentWorkspace),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 70),
            child: Card(
              color: theme.canTapCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isCurrentWorkspace
                          ? "☆ ${corrWorkspace.name}   "
                          : corrWorkspace.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: theme.accentColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // MARK: - Handle Workspace Selection
  void _handleWorkspaceSelection(
    BuildContext context,
    bool isCurrentWorkspace,
  ) {
    SelectEditWorkspaceMethodDialog(
      isCurrentWorkspace: isCurrentWorkspace,
      corrWorkspace: corrWorkspace,
    ).show(context: context);
  }
}
