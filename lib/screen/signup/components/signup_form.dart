import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/widget/al_sign_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SignupForm extends StatelessWidget with GGValidators {
  static final _userData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: '');
  final _emailFN = FocusNode();
  final _passwordFN = FocusNode();
  final _passwordConfirmationFN = FocusNode();

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
              labelText: 'Nome *',
              prefixIconData: Icons.perm_identity,
              validator: emptyValidator,
              onFieldSubmitted: (String value) =>
                  FocusScope.of(context).requestFocus(_emailFN),
              onSaved: (String name) => _userData['name'] = name,
            ),
            FormVerticalSeparator,
            ALSignTextFormField(
              labelText: 'E-mail *',
              prefixIconData: Icons.person,
              validator: emptyValidator,
              focusNode: _emailFN,
              onFieldSubmitted: (String value) =>
                  FocusScope.of(context).requestFocus(_passwordFN),
              onSaved: (String email) => _userData['email'] = email,
            ),
            FormVerticalSeparator,
            ALSignTextFormField(
              labelText: 'Senha *',
              prefixIconData: Icons.vpn_key,
              obscureText: true,
              controller: _passwordController,
              focusNode: _passwordFN,
              validator: emptyValidator,
              onFieldSubmitted: (String value) =>
                  FocusScope.of(context).requestFocus(_passwordConfirmationFN),
              onSaved: (String password) => _userData['password'] = password,
            ),
            FormVerticalSeparator,
            ALSignTextFormField(
              labelText: 'Confirme a senha *',
              prefixIconData: Icons.vpn_key,
              obscureText: true,
              textInputAction: TextInputAction.done,
              focusNode: _passwordConfirmationFN,
              validator: validatePasswordConfirmation,
              onSaved: (String password) => _userData['password'] = password,
            ),
          ],
        ),
      ),
    );
  }

  String validatePasswordConfirmation(String passwordConfirmation) {
    final String confirmMessage = emptyValidator(passwordConfirmation);
    if (confirmMessage != null) {
      return confirmMessage;
    } else if (passwordConfirmation != _passwordController.text) {
      return 'As senhas devem ser iguais.';
    }
    return null;
  }

  FormState getForm() => _formKey.currentState;

  Map<String, String> _getData() {
    return {
      'name': _userData['name'],
      'email': _userData['email'],
      'password': _userData['password']
    };
  }
}
