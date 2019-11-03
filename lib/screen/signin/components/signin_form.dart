import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_sign_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SigninForm extends StatelessWidget with GGValidators {
  final userData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  final _passwordFN = FocusNode();

  // TODO(rodrigo): remove this
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Map<String, String> get data => _getData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: <Widget>[
            ALSignTextFormField(
              labelText: 'E-mail',
              prefixIconData: Icons.person,
              controller: _usernameController,
              validator: emptyValidator,
              onFieldSubmitted: (String value) =>
                  FocusScope.of(context).requestFocus(_passwordFN),
              onSaved: (String email) => userData['email'] = email,
            ),
            FormVerticalSeparator,
            ALSignTextFormField(
              labelText: 'Senha',
              prefixIconData: Icons.vpn_key,
              obscureText: true,
              textInputAction: TextInputAction.done,
              controller: _passwordController,
              focusNode: _passwordFN,
              validator: emptyValidator,
              onSaved: (String password) => userData['password'] = password,
            ),
          ],
        ),
      ),
    );
  }

  FormState getForm() => _formKey.currentState;

  Map<String, String> _getData() {
    return {
      'username': userData['email'],
      'password': userData['password']
    };
  }
}
