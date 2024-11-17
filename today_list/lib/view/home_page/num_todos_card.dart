import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';

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
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth - 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: deviceWidth - 40,
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
                child:
                    // 数の表示
                    Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    numTodos.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: tlThemeData.accentColor,
                        fontSize: 20,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
