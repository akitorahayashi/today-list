import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';

class NumToDosCard extends StatelessWidget {
  final bool ifInToday;
  final int numTodos;
  const NumToDosCard({
    super.key,
    required this.ifInToday,
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: tlThemeConfig.tlDoubleCardBorderColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.only(top: 9.0, bottom: 10.0),
              child: Column(
                children: [
                  // wheneverの場合のラベル
                  if (!ifInToday)
                    const Text("in Whenever",
                        style: TextStyle(
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
      ),
    );
  }
}
