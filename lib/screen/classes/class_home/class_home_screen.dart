import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/class.dart';
import 'package:aluco/screen/classes/call/call_bloc.dart';
import 'package:aluco/screen/classes/call/call_screen.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gg_flutter_components/button/gg_rounded_button.dart';

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
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          ClassHomeActions(),
          const SizedBox(height: 60),
          RaisedButton(
            child: Text(
              'Fazer Chamada',
              style: TextStyle(fontSize: 20),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 24,
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: () => ALRouter.pushWithResolver(
                context,
                CallScreen(),
                () => BlocProvider.getBloc<CallBloc>()
                    .initializeClassStudents(_bloc.pickedClass.id)),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
