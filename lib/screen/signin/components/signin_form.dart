import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SigninForm extends StatelessWidget with GGValidators {

  final userData = {};
  final _formKey = GlobalKey<FormState>();
  final _passwordFN = FocusNode();

  Map<String, String> get data => _getData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Usuário',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordFN),
            validator: emptyValidator,
            onSaved: (username) => userData['username'] = username,
          ),
          FormVerticalSeparator,
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(),
            ),
            focusNode: _passwordFN,
            validator: emptyValidator,
            onSaved: (password) => userData['password'] = password,
          ),
        ],
      ),
    );
  }

  FormState getForm() => _formKey.currentState;

  Map<String, String> _getData() {
    return {
      'username': userData['username'],
      'password': userData['password']
    };
  }
}
