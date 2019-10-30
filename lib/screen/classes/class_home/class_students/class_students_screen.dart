import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/delegate/add_student_class_search_delegate.dart';
import 'package:flutter/material.dart';

class ClassStudentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Turma',
      body: Container(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: AddStudentClassSearchDelegate(),
            );
          },
          child: Icon(Icons.add),
      ),
    );
  }
}
