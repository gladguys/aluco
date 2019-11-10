import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_scaffold_slivered.dart';
import 'package:aluco/widget/al_search_delegate_icon.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:aluco/widget/delegate/student_search_delegate.dart';
import 'package:aluco/widget/empty_state/student_empty_state.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/list_students.dart';
import 'components/save_student_button.dart';
import 'student_bloc.dart';

class ListStudentsScreen extends StatefulWidget {
  @override
  _ListStudentsScreenState createState() => _ListStudentsScreenState();
}

class _ListStudentsScreenState extends State<ListStudentsScreen> {
  StudentBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.getBloc<StudentBloc>();
    getAllStudents();
    super.initState();
  }

  Future<void> getAllStudents() async {
    await _bloc.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<Student>>(
      stream: _bloc.studentStream,
      mainWidget: (dynamic students) => ALScaffoldSlivered(
        title: 'Alunos',
        background: Image.asset(
          'assets/images/alunos_chairs_sliver.jpeg',
          fit: BoxFit.cover,
        ),
        actions: <Widget>[
          ALSearchDelegateIcon<Student>(
            StudentSearchDelegate(),
          ),
        ],
        body:
            students.isNotEmpty ? ListStudents(students) : StudentEmptyState(),
        floatingActionButton: students.isNotEmpty ? SaveStudentButton() : null,
      ),
    );
  }
}
