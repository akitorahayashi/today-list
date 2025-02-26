import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/view/component/common_ui_part/tl_circular_action_button.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view_model/design/tl_icon_data_provider.dart';

class CenterButtonOfHomeBottomNavBar extends ConsumerWidget {
  final bool doesCurrentWorkspaceExist;
  final Function()? onPressed;

  const CenterButtonOfHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    final iconData = doesCurrentWorkspaceExist ? Icons.add : Icons.check;

    return TLCircularActionButton(
      icon: iconData,
      backgroundColor: Colors.white,
      borderColor: Colors.black26,
      iconColor: tlThemeData.accentColor,
      onPressed: onPressed,
    );
  }
}
