import 'package:aluco/model/student_absence.dart';
import 'package:flutter/material.dart';

class StudentAbsencesQuantity extends StatelessWidget {
  const StudentAbsencesQuantity(this.studentAbsence);

  final StudentAbsence studentAbsence;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16),
        const Text(
          'Quantidade de Faltas:',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(studentAbsence.qtAbsences?.toString() ?? '0'),
        ),
      ],
    );
  }
}
