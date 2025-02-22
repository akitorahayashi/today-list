import 'package:flutter/material.dart';
import 'package:today_list/view/component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class AddWorkspaceButton extends StatelessWidget {
  const AddWorkspaceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: GestureDetector(
          onTap: () => const AddOrEditWorkspaceDialog(oldWorkspaceId: null)
              .show(context: context),
          child: Icon(
            Icons.add,
            color: tlThemeConfig.accentColor,
          ),
        ),
      ),
    );
  }
}
