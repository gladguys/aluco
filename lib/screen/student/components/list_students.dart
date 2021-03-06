import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'student_tile.dart';

class ListStudents extends StatelessWidget {
  const ListStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, i) {
          if (i == students.length - 1) {
            return Column(
              children: <Widget>[
                StudentTile(students[i]),
                const SizedBox(height: 80),
              ],
            );
          }
          return Column(
            children: <Widget>[
              StudentTile(students[i]),
              const Divider(height: 1),
            ],
          );
        },
        itemCount: students.length
    );
  }
}
