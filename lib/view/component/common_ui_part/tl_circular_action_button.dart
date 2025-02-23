import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TLCircularActionButton extends HookWidget {
  final IconData icon;
  final double size;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final VoidCallback? onPressed;

  const TLCircularActionButton({
    super.key,
    required this.icon,
    this.size = 70,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isPressed = useState(false);
    final previousIcon = useState<IconData>(icon);

    // アイコンが変更された場合にフェードアニメーションを適用
    useEffect(() {
      if (previousIcon.value != icon) {
        previousIcon.value = icon;
      }
      return null;
    }, [icon]);

    return AnimatedScale(
      scale: isPressed.value ? 0.9 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTapDown: (_) => isPressed.value = true,
        onTapUp: (_) {
          isPressed.value = false;
          onPressed?.call();
        },
        onTapCancel: () => isPressed.value = false,
        child: SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 4),
              ],
              color: backgroundColor,
              border: Border.all(color: borderColor, width: 2),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Icon(
                  icon,
                  key: ValueKey<IconData>(icon), // アイコン変更時にリビルド
                  size: size * 0.5,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
