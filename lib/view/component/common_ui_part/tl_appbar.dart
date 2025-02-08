import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';

class TLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageTitle;
  final Function()? leadingButtonOnPressed;
  final Widget? leadingIcon;
  final Function()? trailingButtonOnPressed;
  final Widget? trailingIcon;
  final double? titleFontSize;
  final double? titleSpacing;
  final List<Widget>? actions;
  final BuildContext context;

  const TLAppBar({
    super.key,
    required this.context,
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
    return Container(
      decoration: BoxDecoration(
        gradient: TLTheme.of(context).gradientOfNavBar,
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
                        ),
                      ),
                    ),
            ],
        title: Text(
          pageTitle,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: titleFontSize ?? 30,
            letterSpacing: titleSpacing ?? 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
