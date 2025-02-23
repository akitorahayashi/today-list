import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TLHomeBottomNavBar extends StatelessWidget {
  final bool doesCurrentWorkspaceExist;
  final VoidCallback? leadingButtonOnPressed;
  final VoidCallback? trailingButtonOnPressed;

  const TLHomeBottomNavBar({
    super.key,
    required this.doesCurrentWorkspaceExist,
    required this.leadingButtonOnPressed,
    required this.trailingButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    const double centerButtonSize = 48;
    const double bottomNavBarHeight = 65;

    final IconData leadingIconData = FontAwesomeIcons.squareCheck;
    final IconData trailingIconData = FontAwesomeIcons.list;

    return Stack(
      children: [
        // グラデーションの背景
        Positioned.fill(
          child: Container(
            height: bottomNavBarHeight,
            decoration: BoxDecoration(
              gradient: tlThemeData.gradientOfNavBar,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black45,
                ),
              ],
            ),
          ),
        ),
        BottomAppBar(
          color: Colors.transparent,
          height: bottomNavBarHeight,
          child: Center(
            child: OverflowBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: [
                _AnimatedSideButton(
                  iconData: leadingIconData,
                  onPressed: leadingButtonOnPressed,
                ),
                const SizedBox(width: centerButtonSize), // 中央のボタン用のスペース
                _AnimatedSideButton(
                  iconData: trailingIconData,
                  onPressed: trailingButtonOnPressed,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - アニメーション付きサイドボタン
class _AnimatedSideButton extends HookWidget {
  final IconData iconData;
  final VoidCallback? onPressed;

  const _AnimatedSideButton({
    required this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) => isPressed.value = false,
      onTapCancel: () => isPressed.value = false,
      onTap: onPressed,
      child: AnimatedScale(
        scale: isPressed.value ? 0.85 : 1.0, // タップ時に85%に縮小
        duration: const Duration(milliseconds: 100),
        child: Icon(
          iconData,
          color: Colors.white,
          size: 33,
        ),
      ),
    );
  }
}
