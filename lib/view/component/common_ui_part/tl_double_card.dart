import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

class TLDoubleCard extends StatelessWidget {
  final double? borderRadius;
  final Widget child;
  const TLDoubleCard({super.key, this.borderRadius, required this.child});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return Card(
      color: tlThemeData.tlDoubleCardBorderColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10)),
      child: Card(
        color: tlThemeData.whiteBasedColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10)),
        child: child,
      ),
    );
  }
}
