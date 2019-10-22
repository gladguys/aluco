import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'signup_form.dart';

class SignupFormButton extends StatelessWidget {

  const SignupFormButton({this.signupForm});

  final SignupForm signupForm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 1),
        Expanded(
          flex: 1,
          child: GGRoundedButton(
            onPressed: () async {
              if (FormUtils.isValid(signupForm.getForm())) {
                print(signupForm.data);
                //await _bloc.tryToSigninUser(userData);
              }
            },
            padding: const EdgeInsets.all(14),
            child: Text(
              'Criar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
