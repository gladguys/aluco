import 'package:flutter/material.dart';

class SigninWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Colors.white;

    return OutlineButton(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 40.0,
      ),
      color: buttonColor,
      textColor: buttonColor,
      borderSide: BorderSide(color: buttonColor),
      highlightedBorderColor: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Text(
        'Entrar com Google',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onPressed: () {},
    );
  }
}
