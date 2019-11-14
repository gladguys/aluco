import 'package:aluco/screen/classes/list_classes/list_classes_bloc.dart';
import 'package:aluco/screen/classes/list_classes/list_classes_screen.dart';
import 'package:aluco/screen/student/list_students_screen.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class HomeActions extends StatelessWidget {
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
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'chalkboard-teacher',
                  weight: IconWeight.Solid,
                ),
                text: 'Turmas',
                route: ListClassesScreen(),
                resolver: () async =>
                    BlocProvider.getBloc<ListClassesBloc>().getAll(),
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'users',
                  weight: IconWeight.Solid,
                ),
                text: 'Alunos',
                route: ListStudentsScreen(),
                resolver: () async =>
                    await BlocProvider.getBloc<StudentBloc>().getAll(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
