import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';

import 'list_class_student_tile.dart';

class ListClassStudents extends StatelessWidget {
  const ListClassStudents(this.students);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index == students.length - 1) {
            return Column(
              children: <Widget>[
                ListClassStudentTile(students[index]),
                const SizedBox(height: 80),
              ],
            );
          }
          return Column(
            children: <Widget>[
              ListClassStudentTile(students[index]),
              const Divider(height: 1),
            ],
          );
        },
        childCount: students.length,
      ),
    );
  }
}
