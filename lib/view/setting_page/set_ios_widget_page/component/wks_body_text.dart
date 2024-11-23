import 'package:flutter/material.dart';

class WKSBodyText extends StatelessWidget {
  final String text;
  const WKSBodyText({
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
