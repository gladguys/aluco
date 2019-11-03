import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'list_class_student_tile.dart';

class ListClassStudents extends StatelessWidget {
  const ListClassStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: students.length,
      itemBuilder: (_, i) {
        if (i == students.length - 1) {
          return Column(
            children: <Widget>[
              ListClassStudentTile(students[i]),
              const SizedBox(height: 80),
            ],
          );
        }
        return ListClassStudentTile(students[i]);
      },
      separatorBuilder: (_, i) => const Divider(height: 1),
    );
  }
}
