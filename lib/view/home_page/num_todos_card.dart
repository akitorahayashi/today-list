import 'package:flutter/material.dart';
import 'package:today_list/model/tl_theme.dart';

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
    final TLThemeData tlThemeData = TLTheme.of(context);
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tlThemeData.panelBorderColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.only(top: 9.0, bottom: 10.0),
                child: Column(
                  children: [
                    // wheneverの場合
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
                          color: tlThemeData.accentColor,
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
      ),
    );
  }
}
