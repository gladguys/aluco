import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'components/create_account_button.dart';
import 'components/signin_form.dart';
import 'components/signin_form_button.dart';
import 'components/signin_with_google_button.dart';

import 'signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with GGValidators {
  final _bloc = SigninBloc();
  final signinForm = SigninForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryColor;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Aluco', style: TextStyle(color: theme, fontSize: 48)),
              Padding(
                padding: const EdgeInsets.all(18),
                child: signinForm,
              ),
              SigninFormButton(signinForm: signinForm),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(thickness: 2),
              ),
              CreateAccountButton(),
              const SizedBox(height: 18),
              SigninWithGoogleButton()
            ],
          ),
        ),
      ),
    );
  }
}
