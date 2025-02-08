import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';

import 'package:animated_gradient_background/animated_gradient_background.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class TLSliverAppBar extends StatelessWidget {
  final double? titleFontSize;
  final double? titleSpacing;
  final String pageTitle;
  final Function()? leadingButtonOnPressed;
  final Widget? leadingIcon;
  final Function()? trailingButtonOnPressed;
  final Widget? trailingIcon;
  final List<Widget>? actions;
  const TLSliverAppBar({
    super.key,
    this.titleFontSize,
    this.titleSpacing,
    required this.pageTitle,
    required this.leadingButtonOnPressed,
    required this.leadingIcon,
    required this.trailingButtonOnPressed,
    required this.trailingIcon,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return SliverAppBar(
      expandedHeight: 110,
      pinned: true,
      centerTitle: true,
      forceElevated: true,

      // pro機能の画面に移動するボタン
      leading: leadingIcon == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: GestureDetector(
                  onTap: leadingButtonOnPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: leadingIcon,
                  )),
            ),
      // 設定画面に移動するボタン
      actions: actions ??
          [
            trailingIcon == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, right: 20),
                    child: GestureDetector(
                        onTap: trailingButtonOnPressed,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: trailingIcon!,
                        )),
                  ),
          ],
      title: Text(
        pageTitle,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: titleFontSize ?? 30,
            letterSpacing: titleSpacing ?? 1,
            overflow: TextOverflow.ellipsis),
      ),
      // AppBarのデザイン
      flexibleSpace: AnimatedGradientBackground(
        colors: tlThemeData.gradientOfNavBar.colors,
        child: const FlexibleSpaceBar(
          title: SizedBox(),
        ),
      ),
    );
  }
}
