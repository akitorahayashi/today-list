import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:today_list/view/component/dialog/for_workspace/select_edit_workspace_method_dialog.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/model/todo/tl_workspace.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';

class ChangeWorkspaceCard extends ConsumerWidget {
  final TLWorkspace corrWorkspace;

  const ChangeWorkspaceCard({
    super.key,
    required this.corrWorkspace,
  });

  // MARK: - UI (Build)
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig theme = TLTheme.of(context);
    final String? currentWorkspaceId = ref
        .watch(tlAppStateProvider.select((state) => state.currentWorkspaceID));
    final bool isCurrentWorkspace = corrWorkspace.id == currentWorkspaceId;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 1, 5, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 70),
        child: GestureDetector(
          onTap: () => _handleWorkspaceSelection(ref, isCurrentWorkspace),
          child: Card(
            color: theme.canTapCardColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
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
  void _handleWorkspaceSelection(WidgetRef ref, bool isCurrentWorkspace) async {
    await SelectEditWorkspaceMethodDialog(
            isCurrentWorkspace: isCurrentWorkspace,
            corrWorkspace: corrWorkspace)
        .show(
      context: ref.context,
    );
    // if (isCurrentWorkspace) {
    //   Navigator.pop(ref.context);
    //   return;
    // }

    // ref.read(tlAppStateProvider.notifier).updateState(
    //     TLAppStateAction.changeCurrentWorkspaceID(corrWorkspace.id));

    // Navigator.pop(ref.context);
  }
}
