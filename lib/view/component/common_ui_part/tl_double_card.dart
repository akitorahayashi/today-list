import 'package:flutter/material.dart';
import '../../../../model/design/tl_theme.dart';

class TlDoubleCard extends StatelessWidget {
  final Widget child;
  const TlDoubleCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
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
