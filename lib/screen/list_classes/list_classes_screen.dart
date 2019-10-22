import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'components/list_classes.dart';

class ListClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Minhas Turmas',
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            MaterialCommunityIcons.getIconData('face-profile'),
            size: 38,
            color: const Color(0xFF389952),
          ),
        ),
      ],
      body: ListClasses(),
    );
  }
}
