import 'package:flutter/material.dart';
import '../../../../model/design/tl_theme.dart';

class CenterButtonOfBottomNavBar extends StatelessWidget {
  final Function()? onPressed;
  const CenterButtonOfBottomNavBar({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    const double buttonSize = 70;
    final double bottomNavbarHeight =
        MediaQuery.of(context).size.height * 100 / 896;
    return Positioned(
      left: MediaQuery.of(context).size.width / 2 - buttonSize / 2,
      bottom: bottomNavbarHeight - buttonSize / 2,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
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
