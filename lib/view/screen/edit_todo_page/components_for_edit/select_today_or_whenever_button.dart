import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

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
        constraints: const BoxConstraints(
          minHeight: 35,
          minWidth: 140,
        ),
        fillColor: tlThemeData.accentColor.withOpacity(0.1),
        selectedColor: tlThemeData.accentColor,
        color: Colors.black54,
        isSelected: [ifInToday, !ifInToday],
        onPressed: (int index) {
          onChanged(index == 0); // true なら今日, falseならいつでも
        },
        children: const [
          Text("今日"),
          Text(" いつでも "),
        ],
      ),
    );
  }
}
