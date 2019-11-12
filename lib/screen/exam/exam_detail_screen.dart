import 'package:aluco/model/exam.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/details_exam.dart';
import 'save_exam_grades.dart';

class ExamDetailScreen extends StatelessWidget {
  const ExamDetailScreen(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Prova',
      subtitle: exam.name,
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 6,
            child: DetailsExam(exam),
          ),
          Flexible(
            flex: 4,
            child: Container(color: Colors.orange,),
          ),
          RaisedButton(
            onPressed: () => ALRouter.push(context, SaveExamGrades()),
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}
