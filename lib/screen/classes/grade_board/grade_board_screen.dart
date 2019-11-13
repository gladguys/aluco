import 'package:aluco/model/student_grades.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/student_grades_list.dart';
import 'grade_board_bloc.dart';

class GradeBoardScreen extends StatefulWidget {
  @override
  _GradeBoardScreenState createState() => _GradeBoardScreenState();
}

class _GradeBoardScreenState extends State<GradeBoardScreen> {

  Future<List<StudentGrades>> studentsGradeFuture;
  final _bloc = GradeBoardBloc();

  @override
  void initState() {
    final classId = BlocProvider.getBloc<ClassHomeBloc>().pickedClass.id;
    studentsGradeFuture = _bloc.getGradesBoard(classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Quadro de Notas',
      body: FutureBuilder<List<StudentGrades>>(
        future: studentsGradeFuture,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            final studentsGrades = snapshot.data;
            return ListView.builder(
              itemCount: studentsGrades.length,
              itemBuilder: (_, i) {
                return ExpansionTile(
                  title: Text('${studentsGrades[i].studentName}: ${studentsGrades[i].average}'),
                  children: <Widget>[
                    StudentGradesList(studentsGrades[i].exams),
                  ],
                );
              },
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
