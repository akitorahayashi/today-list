import 'package:flutter/material.dart';

class DeviceUtil {
  static bool isTablet(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double shortestSide = size.shortestSide;

    return shortestSide >= 600;
  }
}
