import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/empty_state/class_student_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../class_home_bloc.dart';
import 'class_students_bloc.dart';
import 'components/add_student_class_button.dart';
import 'components/list_class_students.dart';

class ClassStudentsScreen extends StatefulWidget {
  @override
  _ClassStudentsScreenState createState() => _ClassStudentsScreenState();
}

class _ClassStudentsScreenState extends State<ClassStudentsScreen> {
  final _classStudentsBloc = BlocProvider.getBloc<ClassStudentsBloc>();
  final _classHomeBloc = BlocProvider.getBloc<ClassHomeBloc>();

  @override
  void initState() {
    _classStudentsBloc.initStudents(_classHomeBloc.pickedClass.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Student>>(
      stream: _classStudentsBloc.studentsInClassController.stream,
      mainWidget: (dynamic students) => ALScaffold(
        title: 'Alunos da Turma',
        body: students.isNotEmpty
            ? ListClassStudents(students)
            : ClassStudentEmptyState(),
        floatingActionButton: students.isNotEmpty ? AddStudentClassButton() : null,
      ),
    );
  }

  @override
  void dispose() {
    _classStudentsBloc.cleanBloc();
    _classHomeBloc.cleanBloc();
    super.dispose();
  }
}
