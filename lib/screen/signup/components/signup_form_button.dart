import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

import '../signup_bloc.dart';
import 'signup_form.dart';

class SignupFormButton extends StatefulWidget {
  const SignupFormButton({this.signupForm});

  final SignupForm signupForm;

  @override
  _SignupFormButtonState createState() => _SignupFormButtonState();
}

class _SignupFormButtonState extends State<SignupFormButton> {
  final _bloc = SignUpBloc();

  @override
  void initState() {
    _bloc.signupStateController.listen(
      (signupState) {
        if (signupState == SignupState.emailAlreadyTaken) {
          GGSnackbar.error(message: 'E-mail não disponível', context: context);
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
        stream: _bloc.signupStateController,
        builder: (_, snapshot) {
          switch (snapshot.data) {
            case SignupState.idle:
            case SignupState.failed:
            case SignupState.succeeded:
            case SignupState.emailAlreadyTaken:
              return const Text(
                'Criar',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              );
            case SignupState.onGoing:
            default:
              return const SizedBox(
                height: 18,
                width: 36,
                child: GGLoadingDoubleBounce(size: 20),
              );
          }
        },
      ),
      onPressed: () async {
        if (FormUtils.isValid(widget.signupForm.getForm())) {
          await _bloc.signUpUser(widget.signupForm.data);
          ALRouter.pop(context);
        }
      },
    );
  }
}
