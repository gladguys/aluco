import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/home/home_screen.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

import '../signin_bloc.dart';
import 'signin_form.dart';

class SigninFormButton extends StatefulWidget {
  const SigninFormButton({this.signinForm});

  final SigninForm signinForm;

  @override
  _SigninFormButtonState createState() => _SigninFormButtonState();
}

class _SigninFormButtonState extends State<SigninFormButton> {
  final SigninBloc _bloc = BlocProvider.getBloc<SigninBloc>();

  @override
  void initState() {
    _bloc.signinStateController.listen(
      (signInState) {
        if (signInState == SigninState.wrongCredentials) {
          GGSnackbar.error(
              message: 'Usuário ou senha inválidos', context: context);
        }
      },
    );
    super.initState();
  }

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
          switch (snapshot.data) {
            case SigninState.idle:
            case SigninState.failed:
            case SigninState.succeeded:
            case SigninState.wrongCredentials:
              return const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              );
            case SigninState.onGoing:
            default:
              return const SizedBox(
                height: 18,
                width: 48,
                child: ALWaitingIndicator(size: 20),
              );
          }
        },
      ),
      onPressed: () async {
        if (FormUtils.isValid(widget.signinForm.getForm())) {
          final loggedUserData =
              await _bloc.tryToSigninUser(widget.signinForm.data);
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
