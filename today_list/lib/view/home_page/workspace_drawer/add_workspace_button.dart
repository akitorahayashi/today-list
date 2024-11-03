import 'package:flutter/material.dart';
import '../../../dialogs/for_workspace/add_or_edit_workspace_dialog.dart';
import '../../../model/tl_theme.dart';

class AddWorkspaceButton extends StatelessWidget {
  const AddWorkspaceButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: GestureDetector(
          onTap: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const AddOrEditWorkspaceDialog(
                    oldIndexInStringWorkspaces: null);
              }),
          child: Icon(
            Icons.add,
            color: _tlThemeData.accentColor,
          ),
        ),
      ),
    );
  }
}
