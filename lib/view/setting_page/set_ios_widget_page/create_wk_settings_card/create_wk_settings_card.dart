import 'package:flutter/material.dart';
import 'package:today_list/model/tl_theme.dart';

class CreateWKSettingsCard extends StatefulWidget {
  const CreateWKSettingsCard({super.key});

  @override
  CreateWKSettingsCardState createState() => CreateWKSettingsCardState();
}

class CreateWKSettingsCardState extends State<CreateWKSettingsCard> {
  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [],
    );
  }
}
