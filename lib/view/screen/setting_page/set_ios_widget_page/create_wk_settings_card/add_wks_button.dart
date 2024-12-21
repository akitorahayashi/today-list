import 'package:flutter/material.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';
import 'package:today_list/model/design/tl_theme.dart';

class AddWKSButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const AddWKSButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return TlDoubleCard(
      child: InkWell(
        onTap: onPressed,
        splashColor: tlThemeData.accentColor.withOpacity(0.05),
        hoverColor: tlThemeData.accentColor.withOpacity(0.05),
        overlayColor:
            WidgetStateProperty.all(tlThemeData.accentColor.withOpacity(0.05)),
        child: SizedBox(
            height: 50,
            width: deviceWidth - 50,
            child: Icon(
              Icons.add,
              color: tlThemeData.accentColor,
            )),
      ),
    );
  }
}
