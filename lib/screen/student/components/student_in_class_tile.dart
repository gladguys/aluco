import 'package:aluco/enums/gender.dart';
import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_bloc.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
      mainWidget: (dynamic studentMarked) {
        return Material(
          color: Colors.white,
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(8),
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 16),
            leading: Icon(
              studentMarked.student.gender == Gender.male
                  ? LineIcons.male
                  : LineIcons.female,
              color:
                  studentMarked.marked ? theme.primaryColor : theme.accentColor,
              size: 40,
            ),
            trailing: CircularCheckBox(
              value: studentMarked.marked,
              materialTapTargetSize: MaterialTapTargetSize.padded,
              activeColor: theme.primaryColor,
              inactiveColor: theme.accentColor,
              onChanged: (marked) {
                BlocProvider.getBloc<ClassStudentsBloc>()
                    .markStudent(studentMarked.student, marked);
              },
            ),
            title: Text(
              studentMarked.student.name,
              style: TextStyle(
                  color: studentMarked.marked
                      ? theme.primaryColor
                      : theme.accentColor),
            ),
            onTap: () => BlocProvider.getBloc<ClassStudentsBloc>()
                .markStudent(studentMarked.student, !studentMarked.marked),
          ),
        );
      },
      loadingIndicator: Container(color: Colors.transparent),
    );
  }
}
