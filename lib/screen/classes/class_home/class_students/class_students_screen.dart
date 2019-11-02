import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
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
      body: StreamBuilder<List<Student>>(
        stream: _classStudentsBloc.studentsInClassStream.stream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListClassStudents(snapshot.data);
          } else if (snapshot.hasError) {
            return ALError();
          }
          return ALWaitingIndicator();
        }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showSearch(context: context, delegate: AddStudentClassSearchDelegate());
            print(_classStudentsBloc.studentsInClassStream.value);
          },
          child: Icon(Icons.add),
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
