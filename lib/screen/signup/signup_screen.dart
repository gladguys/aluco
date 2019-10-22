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
    final theme = Theme.of(context).primaryColor;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Aluco', style: TextStyle(color: theme, fontSize: 48)),
              const SizedBox(height: 12),
              Text('Crie sua conta', style: TextStyle(color: Colors.black, fontSize: 22)),
              Padding(
                padding: const EdgeInsets.all(18),
                child: signupForm,
              ),
              SignupFormButton(signupForm: signupForm),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(thickness: 2),
              ),
              HaveAccountButton()
            ],
          ),
        ),
      ),
    );
  }
}
