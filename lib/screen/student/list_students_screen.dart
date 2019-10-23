import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_error.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:flutter/material.dart';

import 'add_student_screen.dart';
import 'components/list_students.dart';
import 'student_bloc.dart';

class ListStudentsScreen extends StatefulWidget {
  @override
  _ListStudentsScreenState createState() => _ListStudentsScreenState();
}

class _ListStudentsScreenState extends State<ListStudentsScreen> {
  final _bloc = StudentBloc();

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Alunos',
      body: FutureBuilder<dynamic>(
        key: UniqueKey(),
        future: _bloc.getAllStudents(),
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
        onPressed: () => ALRouter.push(context, AddStudentScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
