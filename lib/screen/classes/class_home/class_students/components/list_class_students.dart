import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'list_class_student_tile.dart';

class ListClassStudents extends StatelessWidget {
  const ListClassStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, i) => ListClassStudentTile(students[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: students.length
    );
  }
}
