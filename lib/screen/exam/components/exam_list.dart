import 'package:aluco/model/exam.dart';
import 'package:flutter/material.dart';

import 'exam_tile.dart';

class ExamList extends StatelessWidget {
  const ExamList(this.exams);

  final List<Exam> exams;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: exams.length,
      itemBuilder: (_, i) {
        if (i == exams.length-1) {
          return Column(
            children: <Widget>[
              ExamTile(exams[i]),
              const SizedBox(height: 80),
            ],
          );
        }
        return ExamTile(exams[i]);
      },
      separatorBuilder: (_, i) => const Divider(height: 1),
    );
  }
}
