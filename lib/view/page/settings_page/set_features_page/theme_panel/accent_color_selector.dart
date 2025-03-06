import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/redux/action/tl_user_data_action.dart';
import 'package:today_list/redux/store/tl_app_state_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Reduxの状態更新から分離するためのプロバイダー
final _accentColorSelectorStateProvider = StateProvider<bool>((ref) => false);

class AccentColorSelector extends HookConsumerWidget {
  const AccentColorSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tlThemeConfig = TLTheme.of(context);

    // このプロバイダーを監視することで、このウィジェットの再構築を制御
    ref.watch(_accentColorSelectorStateProvider);

    return _AccentColorSelectorContent(
      initialColor: tlThemeConfig.accentColor,
      defaultAccentColor: tlThemeConfig.defaultAccentColor,
      whiteBasedColor: tlThemeConfig.whiteBasedColor,
      onColorChanged: (Color newColor) {
        // Reduxの状態を更新するが、このウィジェットは再構築されない
        ref.read(tlAppStateProvider.notifier).updateState(
              TLUserDataAction.saveCustomAccentColor(
                newAccentColor: newColor,
              ),
            );
      },
    );
  }
}

// 内部状態を持つStatefulWidgetとして実装
class _AccentColorSelectorContent extends StatefulWidget {
  final Color initialColor;
  final Color defaultAccentColor;
  final Color whiteBasedColor;
  final Function(Color) onColorChanged;

  const _AccentColorSelectorContent({
    required this.initialColor,
    required this.defaultAccentColor,
    required this.whiteBasedColor,
    required this.onColorChanged,
  });

  @override
  State<_AccentColorSelectorContent> createState() =>
      _AccentColorSelectorContentState();
}

class _AccentColorSelectorContentState
    extends State<_AccentColorSelectorContent>
    with SingleTickerProviderStateMixin {
  late Color _currentColor;
  late double _hue;
  late double _saturation;
  late double _value;
  Timer? _debounceTimer;
  bool _colorUpdateScheduled = false;
  bool _isDragging = false;

  // アニメーション用のコントローラー
  late AnimationController _animationController;
  late Animation<double> _animation;

  // 最後に保存した色
  late Color _lastSavedColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
    _lastSavedColor = widget.initialColor;

    final hsvColor = HSVColor.fromColor(_currentColor);
    _hue = hsvColor.hue;
    _saturation = hsvColor.saturation;
    _value = hsvColor.value;

    // アニメーションコントローラーの初期化
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(_AccentColorSelectorContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 外部からの色の変更を検知した場合のみ更新（ドラッグ中は更新しない）
    if (!_isDragging &&
        widget.initialColor.value != oldWidget.initialColor.value) {
      _currentColor = widget.initialColor;
      _lastSavedColor = widget.initialColor;

      final hsvColor = HSVColor.fromColor(_currentColor);
      setState(() {
        _hue = hsvColor.hue;
        _saturation = hsvColor.saturation;
        _value = hsvColor.value;
      });
    }
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  // HSL値から色を更新する関数（ローカルステートのみ更新）
  void _updateColorLocally() {
    final newColor =
        HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor();
    setState(() {
      _currentColor = newColor;
    });
  }

  // ドラッグ開始時の処理
  void _onDragStart() {
    setState(() {
      _isDragging = true;
    });
    // 既存のタイマーをキャンセル
    _debounceTimer?.cancel();
  }

  // ドラッグ終了時の処理
  void _onDragEnd() {
    setState(() {
      _isDragging = false;
    });
    _notifyColorChange();
  }

  // 親ウィジェットに色の変更を通知する関数（ドラッグ終了時に呼び出す）
  void _notifyColorChange() {
    // 色が変わっていない場合は何もしない
    if (_lastSavedColor.value == _currentColor.value) return;

    // 既存のタイマーをキャンセル
    _debounceTimer?.cancel();

    // アニメーションを開始
    _animationController.reset();
    _animationController.forward();

    // 新しいタイマーを設定（500ms後に実行）- アニメーションが完了した後に更新
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (!_colorUpdateScheduled) {
        _colorUpdateScheduled = true;

        // 親ウィジェットに通知
        widget.onColorChanged(_currentColor);

        // 最後に保存した色を更新
        _lastSavedColor = _currentColor;
        _colorUpdateScheduled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // アニメーション中のスケール値
    final scale = 1.0 + (_animation.value * 0.05);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 現在の色を大きく表示
        AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: widget.whiteBasedColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: _currentColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _currentColor.withOpacity(0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // HSLスライダー
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: widget.whiteBasedColor,
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
            children: [
              // 色相スライダー
              Row(
                children: [
                  const SizedBox(
                      width: 30,
                      child: Text('H',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbColor: _currentColor,
                        overlayColor: _currentColor.withOpacity(0.2),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 20),
                      ),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.yellow,
                              Colors.green,
                              Colors.cyan,
                              Colors.blue,
                              Colors.purple,
                              Colors.red,
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          onHorizontalDragStart: (_) => _onDragStart(),
                          onHorizontalDragEnd: (_) => _onDragEnd(),
                          child: Slider(
                            min: 0,
                            max: 360,
                            value: _hue,
                            onChanged: (value) {
                              setState(() {
                                _hue = value;
                                _updateColorLocally();
                              });
                            },
                            onChangeStart: (_) => _onDragStart(),
                            onChangeEnd: (_) => _onDragEnd(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text('${_hue.round()}°', textAlign: TextAlign.right),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 彩度スライダー
              Row(
                children: [
                  const SizedBox(
                      width: 30,
                      child: Text('S',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbColor: _currentColor,
                        overlayColor: _currentColor.withOpacity(0.2),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 20),
                      ),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              HSVColor.fromAHSV(1.0, _hue, 0, _value).toColor(),
                              HSVColor.fromAHSV(1.0, _hue, 1, _value).toColor(),
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          onHorizontalDragStart: (_) => _onDragStart(),
                          onHorizontalDragEnd: (_) => _onDragEnd(),
                          child: Slider(
                            min: 0,
                            max: 1,
                            value: _saturation,
                            onChanged: (value) {
                              setState(() {
                                _saturation = value;
                                _updateColorLocally();
                              });
                            },
                            onChangeStart: (_) => _onDragStart(),
                            onChangeEnd: (_) => _onDragEnd(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text('${(_saturation * 100).round()}%',
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // 明度スライダー
              Row(
                children: [
                  const SizedBox(
                      width: 30,
                      child: Text('V',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        thumbColor: _currentColor,
                        overlayColor: _currentColor.withOpacity(0.2),
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 20),
                      ),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            colors: [
                              HSVColor.fromAHSV(1.0, _hue, _saturation, 0)
                                  .toColor(),
                              HSVColor.fromAHSV(1.0, _hue, _saturation, 1)
                                  .toColor(),
                            ],
                          ),
                        ),
                        child: GestureDetector(
                          onHorizontalDragStart: (_) => _onDragStart(),
                          onHorizontalDragEnd: (_) => _onDragEnd(),
                          child: Slider(
                            min: 0,
                            max: 1,
                            value: _value,
                            onChanged: (newValue) {
                              setState(() {
                                _value = newValue;
                                _updateColorLocally();
                              });
                            },
                            onChangeStart: (_) => _onDragStart(),
                            onChangeEnd: (_) => _onDragEnd(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text('${(_value * 100).round()}%',
                        textAlign: TextAlign.right),
                  ),
                ],
              ),
            ],
          ),
        ),
        // デフォルトに戻すボタン（リッチなデザイン）
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      widget.defaultAccentColor.withOpacity(0.6),
                      widget.defaultAccentColor,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: widget.defaultAccentColor.withOpacity(0.4),
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
      ],
    );
  }

  // 色の明るさに応じてテキスト色を白か黒か判定
  bool _useWhiteForeground(Color color) {
    return (color.computeLuminance() < 0.5);
  }
}
