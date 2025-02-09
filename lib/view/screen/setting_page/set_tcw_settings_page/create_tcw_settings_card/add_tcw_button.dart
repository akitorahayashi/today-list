import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';

class AddToDosInCategoryWidgetSettingsButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddToDosInCategoryWidgetSettingsButton(
      {super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return TLDoubleCard(
      child: InkWell(
        onTap: onPressed,
        splashColor: tlThemeConfig.accentColor.withOpacity(0.05),
        hoverColor: tlThemeConfig.accentColor.withOpacity(0.05),
        overlayColor: WidgetStateProperty.all(
            tlThemeConfig.accentColor.withOpacity(0.05)),
        child: SizedBox(
            height: 50,
            width: deviceWidth - 50,
            child: Icon(
              Icons.add,
              color: tlThemeConfig.accentColor,
            )),
      ),
    );
  }
}
