import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_logo.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'components/have_account_button.dart';
import 'components/signup_form.dart';
import 'components/signup_form_button.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with GGValidators {
  final signupForm = SignupForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/teacherBackground.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Theme.of(context).primaryColor,
              BlendMode.color,
            ),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ALLogo(),
                Text(
                  'Crie sua conta',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18.0,
                  ),
                ),
                FormVerticalSeparator,
                signupForm,
                FormVerticalSeparatorMedium,
                SignupFormButton(signupForm: signupForm),
                FormVerticalSeparator,
                HaveAccountButton()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
