import 'package:flutter/material.dart';

class MediumiOSWidgetReplica extends StatelessWidget {
  const MediumiOSWidgetReplica({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: deviceWidth,
        height: (deviceWidth - 80) / 2,
        child: Card(
          child: Expanded(
            child: Text("koko"),
          ),
        ));
  }
}
