import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import '../../../model/design/tl_theme/tl_theme.dart';

class TLDoubleCard extends StatelessWidget {
  final Widget child;
  const TLDoubleCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return Card(
      color: tlThemeData.tlDoubleCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
