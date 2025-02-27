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
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: tlThemeConfig.gradientOfNavBar,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            spreadRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        forceMaterialTransparency: true,
        toolbarOpacity: 1.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: leadingIconData == null
            ? const SizedBox.shrink()
            : TLAnimatedIconButton(
                icon: leadingIconData!,
                onPressed: leadingButtonOnPressed,
              ),
        actions: trailingIcons ??
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
                              onPressed: trailingButtonOnPressed),
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
              color: tlThemeConfig.whiteBasedColor,
              fontWeight: FontWeight.w900,
              fontSize: titleFontSize ?? 30,
              letterSpacing: titleSpacing ?? 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
