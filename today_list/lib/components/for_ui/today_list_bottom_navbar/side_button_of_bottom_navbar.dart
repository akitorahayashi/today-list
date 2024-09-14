import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideButtonOfBottomNavbar extends StatelessWidget {
  final Function()? onPressed;
  final IconData iconData;
  const SideButtonOfBottomNavbar(
      {super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(iconData,
          color: Colors.white,
          size: iconData == FontAwesomeIcons.houseChimney ? 28 : 33),
    );
  }
}
