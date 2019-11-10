import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_bloc.dart';
import 'package:aluco/widget/al_stream_builder.dart';
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

    return ALStreamBuilder<StudentMarked>(
      stream: BlocProvider.getBloc<ClassStudentsBloc>()
          .allStudentsMarkedListController[index],
      mainWidget: (dynamic studentMarked) => CheckboxListTile(
        title: Text(studentMarked.student.name),
        selected: studentMarked.marked,
        value: studentMarked.marked,
        onChanged: (marked) {
          BlocProvider.getBloc<ClassStudentsBloc>()
              .markStudent(studentMarked.student, marked);
        },
      ),
      loadingIndicator: Container(color: Colors.transparent),
    );
  }
}
