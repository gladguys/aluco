import 'package:aluco/screen/signup/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:simple_router/simple_router.dart';

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(flex: 1),
        Expanded(
          flex: 2,
          child: GGRoundedButton(
            onPressed: () => SimpleRouter.forward(SignupScreen()),
            borderColoredOnly: true,
            borderColor: Color(0xFF009688),
            borderWidth: 2,
            padding: EdgeInsets.all(14),
            child: Text(
              'Criar Conta',
              style: TextStyle(color: Color(0xFF009688), fontSize: 18),
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}