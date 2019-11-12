import 'package:aluco/model/exam.dart';
import 'package:flutter/material.dart';

class DetailsExam extends StatelessWidget {
  const DetailsExam(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(exam.name ?? ''),
        Text(exam.description ?? ''),
      ],
    );
  }
}
