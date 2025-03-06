import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';
import 'package:today_list/model/design/tl_theme_config.dart';
import 'package:today_list/view/component/common_ui_part/tl_double_card.dart';

class NumToDosCard extends StatelessWidget {
  final String? title;
  final int numTodos;
  const NumToDosCard({
    super.key,
    required this.title,
    required this.numTodos,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeConfig = TLTheme.of(context);
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TLDoubleCard(
          borderRadius: 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 7.0, bottom: 8.0),
            child: Column(
              children: [
                // wheneverの場合のラベル
                if (title != null)
                  Text(title!,
                      style: const TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )),
                // 数の表示
                Text(
                  numTodos.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: tlThemeConfig.accentColor,
                      fontSize: 20,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
