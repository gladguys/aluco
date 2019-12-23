import 'package:aluco/widget/al_logo.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/home.dart';
import 'components/profile_appbar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      titleWidget: ALLogo(
        color: Theme.of(context).primaryColor,
        fontSize: 40,
        hasShadow: false,
      ),
      actions: <Widget>[
        ProfileAppbar(),
      ],
      body: Home(),
    );
  }
}
