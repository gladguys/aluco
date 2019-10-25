import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:bloc_provider/bloc_provider.dart';
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
    _bloc = BlocProvider.of<StudentBloc>(context);
    getAllStudents();
    super.initState();
  }

  Future<void> getAllStudents() async {
    await _bloc.getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Alunos',
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => ALRouter.push(context, SaveStudentScreen(blocContext: context)),
        child: Icon(Icons.add),
      ),
    );
  }
}
