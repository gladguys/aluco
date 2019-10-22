import 'package:aluco/model/class.dart';
import 'package:aluco/routing/et_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'student_call_screen.dart';

class ClassInfoScreen extends StatelessWidget {
  const ClassInfoScreen({@required this.classe});

  final Class classe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF389952), //change your color here
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '${classe.name}',
          style: TextStyle(color: const Color(0xFF389952), fontSize: 20),
        ),
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 32,
                      crossAxisSpacing: 32,
                      childAspectRatio: 1),
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF389952))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          classActions[i]['icon'],
                          color: const Color(0xFF389952),
                          size: 80,
                        ),
                        const SizedBox(height: 12),
                        Text(classActions[i]['label'])
                      ],
                    ),
                  ),
                  itemCount: classActions.length,
                ),
              ),
              const Spacer(flex: 1),
              Expanded(
                  flex: 1,
                  child: RaisedButton(
                    shape: Border.all(color: Colors.black),
                    onPressed: () => ETRouter.push(
                        context, StudentCallScreen(classe: classe)),
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
  <String, dynamic>{
    'label': 'Quadro de Notas',
    'icon': Octicons.getIconData('book'),
    'onTap': () => <dynamic>{},
  },
  <String, dynamic>{
    'label': 'Histórico de Chamadas',
    'icon': SimpleLineIcons.getIconData('clock'),
    'onTap': () => <dynamic>{},
  },
  <String, dynamic>{
    'label': 'Plano de Aula',
    'icon': Foundation.getIconData('clipboard-notes'),
    'onTap': () => <dynamic>{},
  },
  <String, dynamic>{
    'label': 'Dados do Aluno',
    'icon': Ionicons.getIconData('ios-person'),
    'onTap': () => <dynamic>{},
  }
];
