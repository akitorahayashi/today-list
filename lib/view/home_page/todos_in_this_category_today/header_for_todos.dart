import 'package:flutter/material.dart';
import '../../../model/todo/tl_category.dart';

class CategoryHeaderForToDos extends StatelessWidget {
  final bool isBigCategory;
  final TLCategory corrCategory;
  const CategoryHeaderForToDos(
      {super.key, required this.isBigCategory, required this.corrCategory});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: isBigCategory ? 40 : 25,
        alignment: Alignment.bottomLeft,
        child: Container(
          margin: EdgeInsets.only(
              left: isBigCategory ? 10 : 30, bottom: isBigCategory ? 3 : 0),
          child: Text(
            corrCategory.title,
            style: isBigCategory
                ? const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black45)
                : const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black45),
          ),
        ));
  }
}
