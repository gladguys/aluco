import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'components/create_account_button.dart';
import 'components/signin_form.dart';
import 'components/signin_form_button.dart';
import 'components/signin_with_google_button.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with GGValidators {
  final signinForm = SigninForm();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final accentColor = Theme.of(context).accentColor;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Aluco',
                style: TextStyle(
                  fontFamily: 'OleoScriptSwashCaps',
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: signinForm,
              ),
              SigninFormButton(signinForm: signinForm),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16),
              //   child: Divider(thickness: 2),
              // ),
              // CreateAccountButton(),
              // const SizedBox(height: 18),
              // SigninWithGoogleButton()
            ],
          ),
        ),
      ),
    );
  }
}
