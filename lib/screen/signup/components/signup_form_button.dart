import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';

import '../signup_bloc.dart';
import 'signup_form.dart';

class SignupFormButton extends StatelessWidget {
  SignupFormButton({this.signupForm});

  final SignupForm signupForm;
  final _bloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(
        vertical: 14.0,
        horizontal: 48.0,
      ),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: const Text(
        'Criar',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onPressed: () async {
        if (FormUtils.isValid(signupForm.getForm())) {
          await _bloc.signUpUser(signupForm.data);
          ALRouter.pop(context);
        }
      },
    );
  }
}
