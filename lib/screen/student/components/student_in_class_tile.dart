import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_bloc.dart';
import 'package:aluco/widget/al_waiting_indicator.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class StudentInClassTile extends StatelessWidget {
  const StudentInClassTile(this.markedStudent);

  final StudentMarked markedStudent;

  @override
  Widget build(BuildContext context) {
    final int index = BlocProvider.getBloc<ClassStudentsBloc>()
        .allStudentsMarkedListController
        .indexWhere((studentController) =>
            studentController.value.student.id == markedStudent.student.id);

    return StreamBuilder<StudentMarked>(
        key: ValueKey(markedStudent.student.id),
        stream: BlocProvider.getBloc<ClassStudentsBloc>()
            .allStudentsMarkedListController[index],
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            return CheckboxListTile(
              title: Text(markedStudent.student.name),
              selected: markedStudent.marked,
              value: markedStudent.marked,
              onChanged: (marked) {
                BlocProvider.getBloc<ClassStudentsBloc>()
                    .markStudent(markedStudent.student, marked);
              },
            );
          }
          return const ALWaitingIndicator();
        });
  }
}
