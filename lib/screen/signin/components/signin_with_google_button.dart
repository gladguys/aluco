import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SigninWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(flex: 1),
        Expanded(
          flex: 3,
          child: GGRoundedButton(
            onPressed: () {},
            borderColoredOnly: true,
            borderColor: Color(0xFFF44336),
            borderWidth: 2,
            padding: EdgeInsets.all(14),
            child: Text(
              'Entrar com Google',
              style: TextStyle(color: Color(0xFFF44336), fontSize: 18),
            ),
          ),
        ),
        Spacer(flex: 1),
      ],
    );
  }
}