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
    final Color primaryColorDark = Theme.of(context).primaryColorDark;

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Column(
          children: <Widget>[
            Material(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(
                      Icons.person,
                      color: primaryColorDark,
                      size: 24.0,
                    ),
                    isDense: true,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(_passwordFN),
                  validator: emptyValidator,
                  onSaved: (email) => userData['email'] = email,
                ),
              ),
            ),
            FormVerticalSeparator,
            Material(
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(12.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: Icon(
                      Icons.vpn_key,
                      color: primaryColorDark,
                      size: 24.0,
                    ),
                    isDense: true,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  obscureText: true,
                  focusNode: _passwordFN,
                  validator: emptyValidator,
                  onSaved: (password) => userData['password'] = password,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FormState getForm() => _formKey.currentState;

  Map<String, String> _getData() {
    return {'email': 'aluco@aluco.com', 'password': '123456'};
    // TODO(rodrigo): remove this
    /*return {
      'username': userData['username'],
      'password': userData['password']
    };*/
  }
}
