import 'package:flutter/material.dart';

class WKSHeader extends StatelessWidget {
  final String text;
  const WKSHeader({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "- $text -",
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
