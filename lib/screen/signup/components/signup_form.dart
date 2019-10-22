import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'person_pickimage_container.dart';

class SignupForm extends StatelessWidget with GGValidators {

  static final _userData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: '');
  final _onPickImage = (String url) => _userData['photo_url'] = url;
  final _passwordFN = FocusNode();
  final _passwordConfirmationFN = FocusNode();

  Map<String, String> get data => _getData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          PersonPickImageContainer(onPickImage: _onPickImage),
          FormVerticalSeparator,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Usuário *',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordFN),
            validator: emptyValidator,
            onSaved: (username) => _userData['username'] = username,
          ),
          FormVerticalSeparator,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha *',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordConfirmationFN),
            focusNode: _passwordFN,
            controller: _passwordController,
            validator: emptyValidator,
            onSaved: (password) => _userData['password'] = password,
          ),
          FormVerticalSeparator,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Confirme a senha *',
              border: OutlineInputBorder(),
            ),
            focusNode: _passwordConfirmationFN,
            validator: validatePasswordConfirmation,
            onSaved: (password) => _userData['password'] = password,
          ),
        ],
      ),
    );
  }

  String validatePasswordConfirmation(String passwordConfirmation) {
    final String confirmMessage = emptyValidator(passwordConfirmation);
    if (confirmMessage != null) {
      return confirmMessage;
    } else if (passwordConfirmation != _passwordController.text) {
      return 'As senhas devem ser idênticas';
    }
    return null;
  }

  FormState getForm() => _formKey.currentState;

  Map<String, String> _getData() {
    return {
      'username': _userData['username'],
      'password': _userData['password'],
      'photo_url': _userData['photo_url'],
    };
  }
}
