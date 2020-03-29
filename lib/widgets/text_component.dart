import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final bool bold;

  TextComponent(
    this.text, {
    this.color = Colors.black,
    this.fontSize = 15,
    this.bold = false
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal
      ),
    );
  }
}
