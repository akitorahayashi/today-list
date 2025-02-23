import 'package:flutter/material.dart';
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

    const double buttonSize = 70;
    const double shadowRadius = 4;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: DecoratedBox(
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: shadowRadius)
            ],
            color: Colors.white,
            border: Border.all(color: Colors.black26, width: 2),
            shape: BoxShape.circle),
        child: ClipOval(
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.resolveWith(
                  (states) => tlThemeData.accentColor.withOpacity(0.1)),
            ),
            child: Icon(
              Icons.add,
              size: 33,
              color: tlThemeData.accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
