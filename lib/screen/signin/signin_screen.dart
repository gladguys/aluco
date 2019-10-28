import 'package:aluco/screen/signin/components/signin_bottom_buttons.dart';
import 'package:aluco/screen/signin/components/signin_logo.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'components/signin_form.dart';
import 'components/signin_form_button.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> with GGValidators {
  final signinForm = SigninForm();

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
                SigninLogo(),
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
