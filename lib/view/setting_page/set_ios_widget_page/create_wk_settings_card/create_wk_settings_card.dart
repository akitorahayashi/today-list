import 'package:flutter/material.dart';
import 'package:today_list/model/tl_theme.dart';

class CreateWKSettingsCard extends StatefulWidget {
  const CreateWKSettingsCard({super.key});

  @override
  CreateWKSettingsCardState createState() => CreateWKSettingsCardState();
}

class CreateWKSettingsCardState extends State<CreateWKSettingsCard> {
  bool _showFirst = true;

  void _toggleCrossfade() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    final TLThemeData tlThemeData = TLTheme.of(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        AnimatedCrossFade(
          duration: const Duration(seconds: 1),
          // +マーク
          firstChild: Card(
              color: tlThemeData.accentColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  onTap: () {},
                  splashColor: tlThemeData.accentColor.withOpacity(0.05),
                  hoverColor: tlThemeData.accentColor.withOpacity(0.05),
                  overlayColor: WidgetStateProperty.all(
                      tlThemeData.accentColor.withOpacity(0.05)),
                  child: SizedBox(
                      height: 50,
                      width: deviceWidth - 50,
                      child: Icon(
                        Icons.add,
                        color: tlThemeData.accentColor,
                      )),
                ),
              )),
          secondChild: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: const Center(child: Text('Second Child')),
          ),
          crossFadeState:
              _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        ),
      ],
    );
  }
}
