import 'package:flutter/material.dart';
import '../../../model/todo/tl_category.dart';
import '../../../model/design/tl_theme.dart';

class TLDropDownButton extends StatefulWidget {
  final String hintText;
  final List<DropdownMenuItem<TLCategory>>? items;
  final Function(TLCategory?)? onChanged;
  const TLDropDownButton({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  State<TLDropDownButton> createState() => _TLDropDownButtonState();
}

class _TLDropDownButtonState extends State<TLDropDownButton> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton(
          iconEnabledColor: _tlThemeData.accentColor,
          isExpanded: true,
          hint: Text(
            widget.hintText,
            style: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
          items: widget.items,

          // カテゴリー変更
          onChanged: widget.onChanged),
    );
  }
}
