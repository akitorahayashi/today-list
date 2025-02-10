import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: ToggleButtons(
        constraints: const BoxConstraints(
          minHeight: 35,
          minWidth: 140,
        ),
        fillColor: Colors.grey[300],
        selectedColor: Colors.blueAccent,
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
