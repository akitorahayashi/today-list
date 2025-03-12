import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/resource/tl_theme_type.dart';

class TLTheme extends InheritedWidget {
  final TLThemeConfig data;

  const TLTheme({super.key, required this.data, required super.child});

  static TLThemeConfig of(BuildContext context) {
    final TLTheme? customTheme =
        context.dependOnInheritedWidgetOfExactType<TLTheme>();
    if (customTheme == null) {
      // デフォルトのTLThemeConfigを返す
      debugPrint('Warning: TLTheme not found in context. Using default theme.');
      // TLThemeTypeのデフォルトテーマを取得
      return TLThemeType.notebook.config;
    }
    return customTheme.data;
  }

  @override
  bool updateShouldNotify(TLTheme oldWidget) {
    return data != oldWidget.data;
  }
}

/// アニメーション付きのテーマウィジェット
class AnimatedTLTheme extends StatefulWidget {
  final TLThemeConfig data;
  final Widget child;
  final Duration duration;
  final Curve curve;

  const AnimatedTLTheme({
    super.key,
    required this.data,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
  });

  @override
  State<AnimatedTLTheme> createState() => _AnimatedTLThemeState();
}

class _AnimatedTLThemeState extends State<AnimatedTLTheme> {
  late TLThemeConfig _data;

  @override
  void initState() {
    super.initState();
    _data = widget.data;
  }

  @override
  void didUpdateWidget(AnimatedTLTheme oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.data != oldWidget.data) {
      setState(() {
        _data = widget.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Color?>(
      tween: ColorTween(
        begin: _data.accentColor,
        end: widget.data.accentColor,
      ),
      duration: widget.duration,
      curve: widget.curve,
      builder: (context, color, child) {
        // アニメーション中のカスタムアクセントカラーを持つ一時的なTLThemeConfig
        final animatedConfig =
            _data.copyWithCustomAccentColor(color ?? widget.data.accentColor);
        return TLTheme(
          data: animatedConfig,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
