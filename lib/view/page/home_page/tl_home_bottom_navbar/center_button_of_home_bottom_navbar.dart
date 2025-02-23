import 'package:flutter/material.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class CenterButtonOfHomeBottomNavBar extends StatelessWidget {
  final bool doesCurrentWorkspaceExist;
  final Function()? onPressed;

  const CenterButtonOfHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return TLCircularActionButton(
      icon: Icons.add,
      backgroundColor: Colors.white,
      borderColor: Colors.black26,
      iconColor: tlThemeData.accentColor,
      onPressed: onPressed,
    );
  }
}
