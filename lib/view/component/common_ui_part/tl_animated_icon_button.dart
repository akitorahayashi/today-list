import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TLAnimatedIconButton extends HookWidget {
  final IconData icon;
  final double size;
  final Color iconColor;
  final VoidCallback? onPressed;

  const TLAnimatedIconButton({
    super.key,
    required this.icon,
    this.size = 26,
    this.iconColor = Colors.white,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);
    final previousIcon = useState<IconData>(icon);

    // アイコンが変わったらフェードアニメーションで更新
    useEffect(() {
      if (previousIcon.value != icon) {
        previousIcon.value = icon;
      }
      return null;
    }, [icon]);

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) {
        isPressed.value = false;
        onPressed?.call();
      },
      onTapCancel: () => isPressed.value = false,
      child: AnimatedScale(
        scale: isPressed.value ? 0.85 : 1.0, // タップ時に85%に縮小
        duration: const Duration(milliseconds: 100),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Icon(
            icon,
            key: ValueKey<IconData>(icon), // アイコン変更を検知
            color: iconColor,
            size: size,
          ),
        ),
      ),
    );
  }
}
