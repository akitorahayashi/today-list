import 'package:flutter/material.dart';
import '../../../model/design/tl_theme.dart';

class ContentCard extends StatelessWidget {
  final Function()? onTap;
  final String contentName;
  const ContentCard(
      {super.key, required this.onTap, required this.contentName});

  @override
  Widget build(BuildContext context) {
    final TLThemeData _tlThemeData = TLTheme.of(context);
    return Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5,
          bottom: 5,
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 70),
            child: Card(
                color: _tlThemeData.panelColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    radius: 10,
                    onTap: onTap,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Text(contentName,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: _tlThemeData.accentColor,
                                letterSpacing: 1)),
                      ),
                    ),
                  ),
                ))));
  }
}
