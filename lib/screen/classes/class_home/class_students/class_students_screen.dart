import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

class ClassStudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Turma',
      body: Container(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          child: Icon(Icons.add),
      ),
    );
  }
}
