import 'package:easyteach/model/class.dart';
import 'package:easyteach/routing/et_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'class_info_screen.dart';

class ClassesScreen extends StatelessWidget {
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
      body: ListView.separated(
          padding: EdgeInsets.all(22),
          itemBuilder: (context, i) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ClassInfoScreen(classe: classes[i]))),
                child: ListTile(
                  leading: Icon(
                    SimpleLineIcons.getIconData('people'),
                    color: Color(0xFF389952),
                  ),
                  title: Text(classes[i].name),
                  subtitle: Text(classes[i].subname),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Color(0xFF389952),
                  ),
                  onTap: () => ETRouter.push(
                    context,
                    ClassInfoScreen(classe: classes[i]),
                  ),
                ),
              ),
          separatorBuilder: (context, i) => Divider(),
          itemCount: classes.length),
    );
  }
}

final classes = [
  Class(name: '8º ANO', subname: 'Turma 8 - A  Sala 32'),
  Class(name: '7º ANO', subname: 'Turma 7 - A  Sala 32'),
  Class(name: '7º ANO', subname: 'Turma 7 - B  Sala 30'),
];
