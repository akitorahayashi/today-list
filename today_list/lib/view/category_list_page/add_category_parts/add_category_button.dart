import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/user/setting_data.dart';

class AddCategoryButton extends StatelessWidget {
  final Function() onTap;
  const AddCategoryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black26, width: 2),
          ),
          child: ClipOval(
            child: Icon(
              Icons.add,
              color: theme[settingData.selectedTheme]!.accentColor,
              size: 30,
            ),
          )),
    );
  }
}
