import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SigninForm extends StatelessWidget with GGValidators {

  final userData = <String, dynamic>{};
  final _formKey = GlobalKey<FormState>();
  final _passwordFN = FocusNode();

  // TODO(rodrigo): remove this
  final _usernameController = TextEditingController(text: 'aluco@aluco.com');
  final _passwordController = TextEditingController(text: '123456');

  Map<String, String> get data => _getData();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'E-mail *',
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (value) => FocusScope.of(context).requestFocus(_passwordFN),
            validator: emptyValidator,
            onSaved: (email) => userData['email'] = email,
          ),
          FormVerticalSeparator,
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Senha *',
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
      'email': 'aluco@aluco.com',
      'password': '123456'
    };
    // TODO(rodrigo): remove this
    /*return {
      'username': userData['username'],
      'password': userData['password']
    };*/
  }
}
