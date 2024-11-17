import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme.dart';

class NumToDosCard extends StatefulWidget {
  final String effortTitle;
  final int numTodos;
  const NumToDosCard({
    super.key,
    required this.effortTitle,
    required this.numTodos,
  });

  @override
  State<NumToDosCard> createState() => _NumToDosCardState();
}

class _NumToDosCardState extends State<NumToDosCard> {
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
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Column(
                  children: [
                    // effortという文字
                    Text(widget.effortTitle,
                        style: const TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        )),
                    // effortの表示
                    Padding(
                      padding: EdgeInsets.only(
                          top: widget.effortTitle == "Effort" ? 5 : 8.0),
                      child: Text(
                        "${widget.numTodos}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: tlThemeData.accentColor,
                            fontSize: 20,
                            letterSpacing: 2,
                            fontWeight: FontWeight.w800),
                      ),
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
