import 'package:flutter/material.dart';

/// デバイス関連のユーティリティクラス
class DeviceUtil {
  /// iPadかどうかを判定するメソッド
  ///
  /// 画面サイズに基づいてタブレットかどうかを判定します。
  /// 一般的に、最短辺が600dp以上のデバイスをタブレットとして扱います。
  ///
  /// @param context BuildContext
  /// @return bool タブレット（iPad）の場合はtrue
  static bool isTablet(BuildContext context) {
    // 画面サイズを取得
    final Size size = MediaQuery.of(context).size;
    final double shortestSide = size.shortestSide;

    // 600dp以上をタブレットとして扱う（Flutterの一般的な基準）
    return shortestSide >= 600;
  }

  /// iPadかどうかを判定するメソッド（isTabletのエイリアス）
  ///
  /// @param context BuildContext
  /// @return bool iPadの場合はtrue
  static bool isIpad(BuildContext context) {
    return isTablet(context);
  }
}
