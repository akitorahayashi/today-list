import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';

class TLHomeBottomNavBar extends StatelessWidget {
  final bool doesCurrentWorkspaceExist;
  final VoidCallback? leadingButtonOnPressed;
  final VoidCallback? trailingButtonOnPressed;

  const TLHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
    required this.leadingButtonOnPressed,
    required this.trailingButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    const double centerButtonSize = 48;
    const double bottomNavBarHeight = 65;

    final IconData leadingIconData = doesCurrentWorkspaceExist
        ? FontAwesomeIcons.squareCheck
        : FontAwesomeIcons.plus;
    final IconData trailingIconData = FontAwesomeIcons.list;

    return Stack(
      children: [
        // グラデーションの背景
        Positioned.fill(
          child: Container(
            height: bottomNavBarHeight,
            decoration: BoxDecoration(
              gradient: tlThemeData.gradientOfNavBar,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
        BottomAppBar(
          color: Colors.transparent,
          height: bottomNavBarHeight,
          child: Center(
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                TLAnimatedIconButton(
                  size: 33,
                  icon: leadingIconData,
                  onPressed: leadingButtonOnPressed,
                ),
                const SizedBox(width: centerButtonSize), // 中央のボタン用のスペース
                TLAnimatedIconButton(
                  size: 33,
                  icon: trailingIconData,
                  onPressed: trailingButtonOnPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
