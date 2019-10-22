import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'components/list_classes.dart';

class ListClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Minhas Turmas',
          style: TextStyle(color: Color(0xFF389952), fontSize: 28),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              MaterialCommunityIcons.getIconData('face-profile'),
              size: 38,
              color: Color(0xFF389952),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListClasses(),
    );
  }
}
