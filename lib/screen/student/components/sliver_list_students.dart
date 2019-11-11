import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'student_tile.dart';

class SliverListStudents extends StatelessWidget {
  const SliverListStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == students.length - 1) {
            return Column(
              children: <Widget>[
                StudentTile(students[index]),
                const SizedBox(height: 80),
              ],
            );
          }
          return Column(
            children: <Widget>[
              StudentTile(students[index]),
              const Divider(height: 1),
            ],
          );
        },
        childCount: students.length,
      ),
    );
  }
}
