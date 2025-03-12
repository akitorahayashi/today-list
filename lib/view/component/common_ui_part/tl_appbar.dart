import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_animated_icon_button.dart';

class TLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double height;
  final String pageTitle;
  final Function()? leadingButtonOnPressed;
  final IconData? leadingIconData;
  final Function()? trailingButtonOnPressed;
  final IconData? trailingIconData;
  final double? titleFontSize;
  final double? titleSpacing;
  final List<Widget>? trailingIcons;
  final PreferredSizeWidget? bottom;
  final double opacity;

  const TLAppBar({
    super.key,
    required this.context,
    this.height = kToolbarHeight,
    this.titleFontSize,
    this.titleSpacing,
    required this.pageTitle,
    required this.leadingButtonOnPressed,
    required this.leadingIconData,
    required this.trailingButtonOnPressed,
    required this.trailingIconData,
    this.trailingIcons,
    this.bottom,
    this.opacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);

    // 透明度に応じてグラデーションの色を調整
    final Gradient backgroundGradient =
        opacity < 1.0
            ? LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                tlThemeConfig.gradientOfNavBar.colors[0].withValues(alpha: 0.7),
                tlThemeConfig.gradientOfNavBar.colors[1].withValues(alpha: 0.7),
              ],
            )
            : tlThemeConfig.gradientOfNavBar;

    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 200),
      child: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          boxShadow:
              opacity < 1.0
                  ? [] // 透明度が低い場合は影を表示しない
                  : const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
        ),
        child: ClipRect(
          // 背景をクリップして透過効果を高める
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: opacity < 1.0 ? 10.0 : 0.0,
              sigmaY: opacity < 1.0 ? 10.0 : 0.0,
            ),
            child: AppBar(
              forceMaterialTransparency: true,
              toolbarOpacity: 1.0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              elevation: 0,
              leading:
                  leadingIconData == null
                      ? const SizedBox.shrink()
                      : TLAnimatedIconButton(
                        icon: leadingIconData!,
                        onPressed: leadingButtonOnPressed,
                      ),
              actions:
                  trailingIcons ??
                  [
                    trailingIconData == null
                        ? Container()
                        : Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: GestureDetector(
                            onTap: trailingButtonOnPressed,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: TLAnimatedIconButton(
                                icon: trailingIconData!,
                                onPressed: trailingButtonOnPressed,
                              ),
                            ),
                          ),
                        ),
                  ],
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Text(
                  pageTitle,
                  key: ValueKey<String>(pageTitle),
                  style: TextStyle(
                    color: tlThemeConfig.navigationTitleColor,
                    fontWeight: FontWeight.w900,
                    fontSize: titleFontSize ?? 30,
                    letterSpacing: titleSpacing ?? 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              bottom: bottom,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
