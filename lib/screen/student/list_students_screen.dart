import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_search_delegate_icon.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:aluco/widget/delegate/student_search_delegate.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/list_students.dart';
import 'save_student_screen.dart';
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
    return ALScaffold(
      title: 'Alunos',
      actions: <Widget>[
        ALSearchDelegateIcon<Student>(
          StudentSearchDelegate(),
        ),
      ],
      body: StreamBuilder<List<Student>>(
        stream: _bloc.studentStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return ListStudents(snapshot.data);
          } else if (snapshot.hasError) {
            return ALError();
          }
          return ALWaitingIndicator();
        },
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
          final Student studentToSave =
              await ALRouter.push(context, const SaveStudentScreen());
          if (studentToSave != null) {
            await _bloc.save(studentToSave);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
