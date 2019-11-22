import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/screen/signup/signup_screen.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.all(12.0),
      textColor: Theme.of(context).accentColor,
      child: const Text(
        'Não tem conta? Crie aqui!',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onPressed: () => ALRouter.push(context, SignupScreen()),
    );
  }
}
