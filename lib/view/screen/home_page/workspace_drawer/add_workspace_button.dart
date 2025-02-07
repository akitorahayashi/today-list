import 'package:flutter/material.dart';
import '../../../component/dialog/for_workspace/add_or_edit_workspace_dialog.dart';
import '../../../../model/design/tl_theme.dart';

class AddWorkspaceButton extends StatelessWidget {
  const AddWorkspaceButton({super.key});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: GestureDetector(
          onTap: () =>
              const AddOrEditWorkspaceDialog(oldIndexInWorkspaces: null)
                  .show(context: context),
          child: Icon(
            Icons.add,
            color: tlThemeData.accentColor,
          ),
        ),
      ),
    );
  }
}
