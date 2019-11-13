import 'package:flutter/material.dart';
import 'package:aluco/model/exam_grade_dto.dart';

class StudentGradesList extends StatelessWidget {
  const StudentGradesList(this.exams);

  final List<ExamGradeDTO> exams;

  @override
  Widget build(BuildContext context) {
    print(exams);
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, i) => Row(
        children: <Widget>[
          Text(exams[i].examName),
          const SizedBox(width: 12),
          Text(exams[i].grade != null ? exams[i].grade.toString() : 'Sem Nota'),
        ],
      ),
      separatorBuilder: (_, i) => const Divider(),
      itemCount: exams.length,
    );
  }
}
