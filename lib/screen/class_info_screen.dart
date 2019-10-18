import 'package:aluco/model/class.dart';
import 'package:aluco/routing/et_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'student_call_screen.dart';

class ClassInfoScreen extends StatelessWidget {
  ClassInfoScreen({@required this.classe});

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF389952), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '${classe.name} - ${classe.subname}',
          style: TextStyle(color: Color(0xFF389952), fontSize: 20),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.only(top: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                      childAspectRatio: 1),
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF389952))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(classActions[i]['icon'],
                            color: Color(0xFF389952), size: 80),
                        SizedBox(height: 12),
                        Text(classActions[i]['label'])
                      ],
                    ),
                  ),
                  itemCount: classActions.length,
                ),
              ),
              Spacer(flex: 1),
              Expanded(
                  flex: 1,
                  child: RaisedButton(
                    shape: Border.all(color: Colors.black),
                    onPressed: () => ETRouter.push(context, StudentCallScreen(classe: classe)),
                    child: Text(
                      'FAZER CHAMADA',
                      style: TextStyle(fontSize: 22, color: Colors.white),
                    ),
                    color: Colors.green,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

final classActions = [
  {
    'label': 'Quadro de Notas',
    'icon': Octicons.getIconData('book'),
    'onTap': () => {},
  },
  {
    'label': 'Histórico de Chamadas',
    'icon': SimpleLineIcons.getIconData('clock'),
    'onTap': () => {},
  },
  {
    'label': 'Plano de Aula',
    'icon': Foundation.getIconData('clipboard-notes'),
    'onTap': () => {},
  },
  {
    'label': 'Dados do Aluno',
    'icon': Ionicons.getIconData('ios-person'),
    'onTap': () => {},
  }
];
