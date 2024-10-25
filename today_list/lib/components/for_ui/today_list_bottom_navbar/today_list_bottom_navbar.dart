import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/user/setting_data.dart';
import './side_button_of_bottom_navbar.dart';

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
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: tlThemeDataList[SettingData.shared.selectedTheme]!
                  .gradientOfNavBar,
              boxShadow: const [
                BoxShadow(blurRadius: 8, color: Colors.black45)
              ],
            ),
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
