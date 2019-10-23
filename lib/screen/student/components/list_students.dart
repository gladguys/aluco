import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'student_tile.dart';

class ListStudents extends StatelessWidget {
  const ListStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, i) => StudentTile(students[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: students.length,
    );
  }
}
