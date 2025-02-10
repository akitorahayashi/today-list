import 'package:flutter/material.dart';
import 'package:today_list/model/design/tl_theme/tl_theme_config.dart';
import '../../../../model/design/tl_theme/tl_theme.dart';

class PanelWithTitle extends StatelessWidget {
  final String title;
  final List<Widget> contents;
  const PanelWithTitle({
    super.key,
    required this.title,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    final TLThemeConfig tlThemeData = TLTheme.of(context);
    return Card(
      color: tlThemeData.settingPanelColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3.5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(5, 12, 5, 5),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 3, 0, 3),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(title,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: tlThemeData.titleColorOfSettingPage)),
              ),
            ),
            Card(
              color: tlThemeData.whiteBasedCardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: contents,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
