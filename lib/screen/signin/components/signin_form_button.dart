import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'signin_form.dart';

class SigninFormButton extends StatelessWidget {

  const SigninFormButton({this.signinForm});

  final SigninForm signinForm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(flex: 1),
        Expanded(
          flex: 1,
          child: GGRoundedButton(
            onPressed: () async {
              if (FormUtils.isValid(signinForm.getForm())) {
                //await _bloc.tryToSigninUser(userData);
                ALRouter.pushAndReplace(context, HomeScreen());
              }
            },
            padding: const EdgeInsets.all(14),
            child: Text(
              'Entrar',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
