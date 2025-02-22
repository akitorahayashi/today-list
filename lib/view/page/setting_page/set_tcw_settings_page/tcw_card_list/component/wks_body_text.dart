import 'package:flutter/material.dart';

class TCWBodyText extends StatelessWidget {
  final String text;
  const TCWBodyText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.black45,
      ),
    );
  }
}
