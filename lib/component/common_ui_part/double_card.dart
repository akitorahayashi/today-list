import 'package:flutter/material.dart';
import '../../model/design/tl_theme.dart';

class DoubleCard extends StatelessWidget {
  final Widget child;
  const DoubleCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Card(
      color: _tlThemeData.niceAppsCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
}
