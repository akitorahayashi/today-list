import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class TLBottomNavBar extends StatelessWidget {
  final IconData leadingIconData;
  final Function()? leadingButtonOnPressed;
  final IconData trailingIconData;
  final Function()? trailingButtonOnPressed;

  const TLBottomNavBar({
    super.key,
    required this.leadingIconData,
    required this.leadingButtonOnPressed,
    required this.trailingIconData,
    required this.trailingButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    const double centerButtonSize = 48;
    const double bottomNavBarHeight = 60;

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // グラデーションの背景
        Positioned.fill(
          child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSideButton(leadingIconData, leadingButtonOnPressed),
              const SizedBox(width: centerButtonSize), // 中央のボタン用のスペース
              _buildSideButton(trailingIconData, trailingButtonOnPressed),
            ],
          ),
        ),
      ],
    );
  }

  /// サイドボタンの構築
  Widget _buildSideButton(IconData iconData, Function()? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        color: Colors.white,
        size: 33,
      ),
    );
  }
}
