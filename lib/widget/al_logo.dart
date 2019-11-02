import 'package:flutter/material.dart';

class ALLogo extends StatelessWidget {
  const ALLogo({
    this.fontSize = 64,
    this.color = Colors.white,
    this.hasShadow = true,
  });

  final double fontSize;
  final Color color;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Aluco',
      style: TextStyle(
        fontFamily: 'OleoScriptSwashCaps',
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
        shadows: hasShadow
            ? [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.grey,
                ),
              ]
            : null,
      ),
    );
  }
}
