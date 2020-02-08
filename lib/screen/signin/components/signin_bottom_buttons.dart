import 'package:aluco/screen/signin/components/create_account_button.dart';
import 'package:aluco/screen/signin/components/signin_with_google_button.dart';
import 'package:flutter/material.dart';

class SigninBottomButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        direction: Axis.vertical,
        spacing: 8.0,
        children: <Widget>[
          CreateAccountButton(),
          SigninWithGoogleButton(),
        ],
      ),
    );
  }
}
