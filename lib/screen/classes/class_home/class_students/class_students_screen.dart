import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/delegate/add_student_class_search_delegate.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../class_home_bloc.dart';
import 'class_students_bloc.dart';
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
    return ALScaffold(
      title: 'Alunos da Turma',
      body: ALStreamBuilder<List<Student>>(
        stream: _classStudentsBloc.studentsInClassController.stream,
        mainWidget: (dynamic students) => ListClassStudents(students),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: const Text(
          'Adicionar',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).accentColor,
        onPressed: () async {
          await showSearch(
              context: context, delegate: AddStudentClassSearchDelegate());
        },
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
