import 'package:flutter/material.dart';
import './other_apps_panel/other_apps_panel.dart';

class OtherAppsPage extends StatelessWidget {
  const OtherAppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        OtherAppsPanel(),
        SizedBox(height: 250),
      ],
    );
  }
}
