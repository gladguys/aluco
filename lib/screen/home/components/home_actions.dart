import 'package:aluco/core/utils/global_keys.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_bloc.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_screen.dart';
import 'package:aluco/screen/signin/signin_bloc.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomeActions extends StatefulWidget {
  @override
  _HomeActionsState createState() => _HomeActionsState();
}

class _HomeActionsState extends State<HomeActions> {
  List<TargetFocus> targets = [];
  final classesKey = GlobalKey();
  final studentsKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    if (!PrefUtils.isFirstLoginDone()) {
      _setupTargets();
      WidgetsBinding.instance.addPostFrameCallback((_) => _showTutorial());
    }
  }

  void _setupTargets() {
    targets.add(
      TargetFocus(
        identify: 'Target 3',
        keyTarget: profileKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Informações do Usuário',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Clicando aqui você tem informações do seu usuário e pode deslogar do app',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'Target 1',
        keyTarget: classesKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Gerenciamento de turmas',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Aqui você pode criar e editar novas turmas, além de vincular os alunos às suas respectivas turmas.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: 'Target 2',
        keyTarget: studentsKey,
        contents: [
          ContentTarget(
            align: AlignContent.bottom,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Gerenciamento de alunos',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Cadastre os alunos das escolas que você ensina.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTutorial() async {
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.orange[600],
      textSkip: 'Pular',
      textStyleSkip: const TextStyle(fontSize: 22, color: Colors.white),
      paddingFocus: 10,
      finish: () async {
        await BlocProvider.getBloc<SigninBloc>().markFirstLoginDone();
      },
      clickTarget: (target) {},
      clickSkip: () {
        print('skip');
      },
    )..show();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              Container(
                key: classesKey,
                child: ALIconTextVerticalButton(
                  icon: FontAwesome5.getIconData(
                    'chalkboard-teacher',
                    weight: IconWeight.Solid,
                  ),
                  text: 'Turmas',
                  route: ListClassesScreen(),
                  resolver: () async =>
                      BlocProvider.getBloc<ListClassesBloc>().getAll(),
                ),
              ),
              Container(
                key: studentsKey,
                child: ALIconTextVerticalButton(
                  icon: FontAwesome5.getIconData(
                    'users',
                    weight: IconWeight.Solid,
                  ),
                  text: 'Alunos',
                  route: ListStudentsScreen(),
                  resolver: () async =>
                      await BlocProvider.getBloc<StudentBloc>().getAll(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
