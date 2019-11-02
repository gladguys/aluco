import 'package:aluco/model/student_marked.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

class StudentInClassTile extends StatefulWidget {
  const StudentInClassTile(this.markedStudent);

  final StudentMarked markedStudent;

  @override
  _StudentInClassTileState createState() => _StudentInClassTileState();
}

class _StudentInClassTileState extends State<StudentInClassTile> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      key: ValueKey(widget.markedStudent.student.id),
      title: Text(widget.markedStudent.student.name),
      selected: widget.markedStudent.marked,
      value: widget.markedStudent.marked,
      onChanged: (marked) {
        BlocProvider.getBloc<ClassStudentsBloc>()
            .markStudent(widget.markedStudent.student, marked);

        // TODO(rodrigo): se livrar disso depois
        setState((){});
      },
    );
  }
}
