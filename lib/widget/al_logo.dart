import 'package:flutter/material.dart';

class ALLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Aluco',
      style: TextStyle(
        fontFamily: 'OleoScriptSwashCaps',
        fontSize: 64,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
