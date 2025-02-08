import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/today_list_bottom_navbar/side_button_of_bottom_navbar.dart';

class TodayListBottomNavbar extends StatelessWidget {
  final IconData leadingIconData;
  final Function()? leadingButtonOnPressed;
  final IconData trailingIconData;
  final Function()? tralingButtonOnPressed;
  const TodayListBottomNavbar(
      {super.key,
      required this.leadingIconData,
      required this.leadingButtonOnPressed,
      required this.trailingIconData,
      required this.tralingButtonOnPressed});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: tlThemeData.gradientOfNavBar,
                boxShadow: const [
                  BoxShadow(blurRadius: 8, color: Colors.black45)
                ]),
            child: SizedBox(
              width: deviceWidth,
              height: MediaQuery.of(context).size.height * 100 / 896,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SideButtonOfBottomNavbar(
                          onPressed: leadingButtonOnPressed,
                          iconData: leadingIconData),
                      SideButtonOfBottomNavbar(
                          onPressed: tralingButtonOnPressed,
                          iconData: trailingIconData),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
