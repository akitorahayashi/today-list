import 'package:flutter/material.dart';
import '../../../model/design/tl_theme.dart';

class AddCategoryButton extends StatelessWidget {
  final Function() onTap;
  const AddCategoryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.black26, width: 2),
          ),
          child: ClipOval(
            child: Icon(
              Icons.add,
              color: _tlThemeData.accentColor,
              size: 30,
            ),
          )),
    );
  }
}
