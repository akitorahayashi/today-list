import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// 現在の色を保持するプロバイダー
final _currentColorProvider = StateProvider<Color>((ref) => Colors.blue);

class AccentColorSelector extends HookConsumerWidget {
  const AccentColorSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tlThemeConfig = TLTheme.of(context);

    // 現在の色を監視
    final currentColor = ref.watch(_currentColorProvider);

    // 初期化時に現在の色をセット (useEffectの外でプロバイダーを更新しないようにする)
    useEffect(() {
      // 非同期で実行することで、ビルド中にプロバイダーを更新しないようにする
      Future.microtask(() {
        ref.read(_currentColorProvider.notifier).state =
            tlThemeConfig.accentColor;
      });
      return null;
    }, const []);

    // 色を変更する関数
    void onColorChanged(Color newColor) {
      ref.read(_currentColorProvider.notifier).state = newColor;
      ref.read(tlAppStateProvider.notifier).updateState(
            TLUserDataAction.saveCustomAccentColor(
              newAccentColor: newColor,
            ),
          );
    }

    // デフォルトの色に戻す関数
    void resetToDefaultColor() {
      onColorChanged(tlThemeConfig.defaultAccentColor);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 現在の色を表示 (タップでカラーピッカーを表示)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TappableColorPreview(
            currentColor: currentColor,
            whiteBasedColor: tlThemeConfig.whiteBasedColor,
            onTap: () =>
                _showColorPicker(context, currentColor, onColorChanged),
          ),
        ),

        // デフォルトに戻すボタン
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
          child: ResetButton(
            defaultAccentColor: tlThemeConfig.defaultAccentColor,
            onReset: resetToDefaultColor,
          ),
        ),
      ],
    );
  }

  // カラーピッカーダイアログを表示
  void _showColorPicker(BuildContext context, Color currentColor,
      Function(Color) onColorChanged) {
    Color pickerColor = currentColor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('アクセントカラーを選択'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: (Color color) {
                pickerColor = color;
              },
              pickerAreaHeightPercent: 0.8,
              enableAlpha: false,
              displayThumbColor: true,
              paletteType: PaletteType.hsl,
              portraitOnly: true,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: pickerColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('決定'),
              onPressed: () {
                onColorChanged(pickerColor);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// タップ可能なアニメーション付き色のプレビュー表示
class TappableColorPreview extends HookWidget {
  final Color currentColor;
  final Color whiteBasedColor;
  final VoidCallback onTap;

  const TappableColorPreview({
    super.key,
    required this.currentColor,
    required this.whiteBasedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // タップアニメーション用
    final isPressed = useState(false);

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true,
      onTapUp: (_) {
        isPressed.value = false;
        onTap();
      },
      onTapCancel: () => isPressed.value = false,
      child: AnimatedScale(
        scale: isPressed.value ? 0.9 : 1.0,
        duration: const Duration(milliseconds: 150),
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: whiteBasedColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 色のプレビュー
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: currentColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: currentColor.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),

              // タップして色を選択するテキスト
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.touch_app,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'タップして色を選択',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// リセットボタン
class ResetButton extends HookWidget {
  final Color defaultAccentColor;
  final VoidCallback onReset;

  const ResetButton({
    super.key,
    required this.defaultAccentColor,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    // リセットボタンのアニメーション用
    final isPressed = useState(false);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GestureDetector(
          onTapDown: (_) => isPressed.value = true,
          onTapUp: (_) {
            isPressed.value = false;
            onReset();
          },
          onTapCancel: () => isPressed.value = false,
          child: AnimatedScale(
            scale: isPressed.value ? 0.9 : 1.0,
            duration: const Duration(milliseconds: 150),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    defaultAccentColor.withOpacity(0.6),
                    defaultAccentColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: defaultAccentColor.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'デフォルトに戻す',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
