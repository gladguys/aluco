import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_scaffold_slivered.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/empty_state/class_student_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../../../../loading_bloc.dart';
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
  final _loadingBloc = BlocProvider.getBloc<LoadingBloc>();

  @override
  void initState() {
    _loadingBloc.startLoading();
    _classStudentsBloc.initStudents(_classHomeBloc.pickedClass.id).then((v) {
      _loadingBloc.stopLoading();
    });
    super.initState();
  }

  Future<void> initStudents() async {
    await _classStudentsBloc.initStudents(_classHomeBloc.pickedClass.id);
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Student>>(
      stream: _classStudentsBloc.studentsInClassController.stream,
      mainWidget: (dynamic students) => ALScaffoldSlivered(
        title: const Text('Alunos da Turma', style: TextStyle(color: Colors.orange),),
        body: students.isNotEmpty
            ? ListClassStudents(students)
            : ClassStudentEmptyState(),
        floatingActionButton:
            students.isNotEmpty ? AddStudentClassButton() : null,
        background: Image.asset(
          'assets/images/alunos_sliver.jpeg',
          fit: BoxFit.cover,
        ),
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
