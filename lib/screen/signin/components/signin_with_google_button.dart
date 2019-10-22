import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SigninWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: GGRoundedButton(
            onPressed: () {},
            borderColoredOnly: true,
            borderColor: const Color(0xFFF44336),
            borderWidth: 2,
            padding: const EdgeInsets.all(14),
            child: Text(
              'Entrar com Google',
              style: TextStyle(color: const Color(0xFFF44336), fontSize: 18),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}