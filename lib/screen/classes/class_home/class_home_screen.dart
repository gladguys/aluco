import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

import 'class_home_bloc.dart';
import 'class_students/class_students_screen.dart';

class ClassHomeScreen extends StatefulWidget {
  const ClassHomeScreen(this._class);

  final Class _class;

  @override
  _ClassHomeScreenState createState() => _ClassHomeScreenState();
}

class _ClassHomeScreenState extends State<ClassHomeScreen> {
  ClassHomeBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<ClassHomeBloc>()..setClass(widget._class);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: _bloc.pickedClass.name,
      body: ClassHomeActions(),
    );
  }
}

class ClassHomeActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemBuilder: (_, i) => GGIconLabelContainer(
          icon: Icon(homeActions[i]['icon'], size: 60),
          text: Text(homeActions[i]['text'], style: TextStyle(fontSize: 22),),
          onTap: () => ALRouter.push(context, homeActions[i]['target']),
        ),
        itemCount: homeActions.length,
      ),
    );
  }
}

final homeActions = <Map<String, dynamic>>[
  <String, dynamic>{
    'icon': Ionicons.getIconData('ios-people'),
    'text': 'Alunos da Turma',
    'target': ClassStudentsScreen()
  },
  <String, dynamic>{
    'icon': Foundation.getIconData('clipboard-notes'),
    'text': 'Histórico de Chamadas',
    'target': ListStudentsScreen()
  },
  <String, dynamic>{
    'icon': MaterialIcons.getIconData('grade'),
    'text': 'Quadro de Notas',
    'target': ListStudentsScreen()
  },
  <String, dynamic>{
    'icon': Entypo.getIconData('open-book'),
    'text': 'Planos de Aulas',
    'target': ListStudentsScreen()
  },
];