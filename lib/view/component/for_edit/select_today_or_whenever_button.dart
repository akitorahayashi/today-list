import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';

class SelectTodayOrWheneverButton extends StatelessWidget {
  final bool ifInToday;
  final ValueChanged<bool> onChanged;

  const SelectTodayOrWheneverButton({
    super.key,
    required this.ifInToday,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: ToggleButtons(
        // レイアウト
        constraints: const BoxConstraints(minHeight: 35, minWidth: 140),

        // スタイル
        fillColor: tlThemeData.accentColor.withValues(alpha: 0.1), // 透明度を調整
        selectedColor: tlThemeData.accentColor, // 選択時の文字色
        color: Colors.black54, // 未選択時の文字色
        splashColor: Colors.transparent, // タップ時のスプラッシュを無効化
        hoverColor: Colors.transparent, // ホバー時のエフェクトを無効化
        // 動作
        isSelected: [ifInToday, !ifInToday],
        onPressed: (int index) {
          onChanged(index == 0); // true なら「今日」、false なら「いつでも」
        },

        // ボタンの内容
        children: const [Text("今日"), Text(" いつでも ")],
      ),
    );
  }
}
