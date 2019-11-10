import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'class_home_actions.dart';
import 'class_home_bloc.dart';

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
      title: 'Turma',
      subtitle: _bloc.pickedClass.name,
      body: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: ClassHomeActions(),
      ),
    );
  }
}
