import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../model/todo/tl_category.dart';
import '../../../../../model/design/tl_theme.dart';

class SelectCategoryDropDown extends ConsumerWidget {
  final String hintText;
  final List<DropdownMenuItem<TLCategory>>? items;
  final Function(TLCategory?)? onChanged;
  const SelectCategoryDropDown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: DropdownButton(
          iconEnabledColor: tlThemeData.accentColor,
          isExpanded: true,
          hint: Text(
            hintText,
            style: const TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.bold,
          ),
          items: items,

          // カテゴリー変更
          onChanged: onChanged),
    );
  }
}
