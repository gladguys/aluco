import 'package:easyteach/model/class.dart';
import 'package:flutter/material.dart';

import 'class_info_screen.dart';


class ClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Turmas'),),
      body: ListView.separated(
          itemBuilder: (context, i) => GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ClassInfoScreen(classe: classes[i]))),
            child: ListTile(
              title: Text(classes[i].name),
            ),
          ),
          separatorBuilder: (context, i) => Divider(),
          itemCount: classes.length
      ),
    );
  }
}

final classes = [
  Class(name: 'Turma 1 Manhã'),
  Class(name: 'Turma 2 Manhã'),
  Class(name: 'Turma 3 Manhã'),
  Class(name: 'Turma 1 Tarde'),
  Class(name: 'Turma 2 Tarde'),
];