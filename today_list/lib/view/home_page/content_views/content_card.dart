import 'package:flutter/material.dart';
import '../../../constants/theme.dart';
import '../../../model/user/setting_data.dart';

class ContentCard extends StatelessWidget {
  final Function()? onTap;
  final String contentName;
  const ContentCard(
      {super.key, required this.onTap, required this.contentName});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5,
          bottom: 5,
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 70),
            child: Card(
                color: theme[settingData.selectedTheme]!.panelColor,
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
                                color: theme[settingData.selectedTheme]!
                                    .accentColor,
                                letterSpacing: 1)),
                      ),
                    ),
                  ),
                ))));
  }
}
