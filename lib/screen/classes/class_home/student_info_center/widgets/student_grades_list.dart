import 'package:aluco/model/exams_period.dart';
import 'package:aluco/model/period_content.dart';
import 'package:aluco/model/student_grades.dart';
import 'package:flutter/material.dart';

class StudentGradesList extends StatelessWidget {
  const StudentGradesList(this.studentGrades);

  final StudentGrades studentGrades;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildPeriodGrades(studentGrades.periodOne),
        _buildPeriodGrades(studentGrades.periodTwo),
        _buildPeriodGrades(studentGrades.periodThree),
        _buildPeriodGrades(studentGrades.periodFour),
      ],
    );
  }

  Widget _buildPeriodGrades(PeriodContent periodContent) {
    if (periodContent.examsPeriod != null &&
        periodContent.examsPeriod.isNotEmpty) {
      return Column(
        children: <Widget>[
          Text('Média do Bimestre: ${periodContent.average}'),
          ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, i) => ExamTile(periodContent.examsPeriod[i]),
            itemCount: periodContent.examsPeriod.length,
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}

class ExamTile extends StatelessWidget {
  const ExamTile(this.examsPeriod);

  final ExamsPeriod examsPeriod;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(examsPeriod.examName),
      trailing: Text(examsPeriod.grade.toStringAsFixed(2)),
    );
  }
}
