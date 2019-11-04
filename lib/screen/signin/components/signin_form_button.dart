import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../signin_bloc.dart';
import 'signin_form.dart';

class SigninFormButton extends StatelessWidget {
  SigninFormButton({this.signinForm});

  final SigninBloc _bloc = BlocProvider.getBloc<SigninBloc>();
  final SigninForm signinForm;

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
      child: StreamBuilder(
        stream: _bloc.signinStateController,
        builder: (_, snapshot) {
          if (snapshot.data == SigninState.idle) {
            return const Text(
              'Entrar',
              style: TextStyle(
                fontSize: 16.0,
              ),
            );
          } else {
            return const SizedBox(
              height: 18,
              width: 48,
              child: ALWaitingIndicator(size: 20),
            );
          }
        },
      ),
      onPressed: () async {
        if (FormUtils.isValid(signinForm.getForm())) {
          final loggedUserData = await _bloc.tryToSigninUser(signinForm.data);
          if (loggedUserData != null) {
            await _bloc.storeJWTInfo(loggedUserData);
            _bloc.setAuthorizationHeader();
            ALRouter.pushAndReplace(context, HomeScreen());
          }
        }
      },
    );
  }
}
