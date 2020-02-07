import 'package:aluco/model/class.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_snackbar.dart';

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

  Class get classe => widget._class;

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
          const SizedBox(height: 12),
          if (classe.classStatus == ClassStatus.created)
            Container(
              child: RaisedButton(
                child: const Text('Iniciar Turma'),
                onPressed: () async {
                  await _bloc.initializeClass(classe.id);
                  GGSnackbar.success(
                    message: 'Classe iniciada com sucesso!',
                    context: context,
                  );
                  setState(() {});
                  print(_bloc.pickedClass.classStatus);
                },
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
