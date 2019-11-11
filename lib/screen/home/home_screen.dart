import 'package:aluco/widget/al_logo.dart';
import 'package:aluco/widget/al_logout_button.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'components/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      titleWidget: ALLogo(
        color: Theme.of(context).primaryColor,
        fontSize: 40,
        hasShadow: false,
      ),
      actions: kReleaseMode
          ? <Widget>[
              Image.asset(
                'assets/images/user.png',
                fit: BoxFit.scaleDown,
                width: 34,
              ),
              const SizedBox(width: 12.0),
              ALLogoutButton(),
            ]
          : <Widget>[
              ALLogoutButton(),
            ],
      body: Home(),
    );
  }
}
