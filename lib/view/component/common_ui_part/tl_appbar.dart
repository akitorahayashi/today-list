import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class TLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double height;
  final String pageTitle;
  final Function()? leadingButtonOnPressed;
  final Widget? leadingIcon;
  final Function()? trailingButtonOnPressed;
  final Widget? trailingIcon;
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
    required this.leadingIcon,
    required this.trailingButtonOnPressed,
    required this.trailingIcon,
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
        leading: leadingIcon == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: GestureDetector(
                  onTap: leadingButtonOnPressed,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: leadingIcon,
                  ),
                ),
              ),
        actions: trailingIcons ??
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
                        ),
                      ),
                    ),
            ],
        title: Text(
          pageTitle,
          style: TextStyle(
            color: tlThemeConfig.whiteBasedColor,
            fontWeight: FontWeight.w900,
            fontSize: titleFontSize ?? 30,
            letterSpacing: titleSpacing ?? 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        bottom: bottom,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
