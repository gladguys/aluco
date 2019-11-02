import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/home.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Home',
      body: Home(),
    );
  }
}
