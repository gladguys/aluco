import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/screen/signin/components/signin_bottom_buttons.dart';
import 'package:aluco/widget/al_logo.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:gg_flutter_components/loading/gg_loading_barrier.dart';

import 'components/signin_form.dart';
import 'components/signin_form_button.dart';
import 'signin_bloc.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with GGValidators {
  final signinForm = SigninForm();
  final SigninBloc _bloc = BlocProvider.getBloc<SigninBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.signinStateController.listen((signinState) {
      if (signinState == SigninState.onGoing) {
        GGLoadingBarrier.show(context);
      } else if (signinState == SigninState.succeeded) {
        _bloc.signinStateController.add(SigninState.idle);
        GGLoadingBarrier.hide(context);
      }
    });
  }

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
                const ALLogo(),
                FormVerticalSeparator,
                signinForm,
                FormVerticalSeparatorMedium,
                SigninFormButton(signinForm: signinForm),
                FormVerticalSeparatorMedium,
                SigninBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
