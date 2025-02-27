import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

class TLTheme extends InheritedWidget {
  final TLThemeConfig data;

  const TLTheme({super.key, required this.data, required super.child});

  static TLThemeConfig of(BuildContext context) {
    final TLTheme? customTheme =
        context.dependOnInheritedWidgetOfExactType<TLTheme>();
    return customTheme!.data;
  }

  @override
  bool updateShouldNotify(TLTheme oldWidget) {
    return data != oldWidget.data;
  }
}
