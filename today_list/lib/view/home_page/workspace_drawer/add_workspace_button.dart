import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/user/setting_data.dart';
import '../../../crud/for_workspace/add_or_edit_workspace_alert.dart';

class AddWorkspaceButton extends StatelessWidget {
  const AddWorkspaceButton({super.key});

  @override
  Widget build(BuildContext context) {
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
            color:
                tlThemeDataList[SettingData.shared.selectedTheme]!.accentColor,
          ),
        ),
      ),
    );
  }
}
