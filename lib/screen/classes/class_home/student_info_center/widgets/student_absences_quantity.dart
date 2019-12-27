import 'package:aluco/model/student_absence.dart';
import 'package:flutter/material.dart';

class StudentAbsencesQuantity extends StatelessWidget {
  const StudentAbsencesQuantity(this.studentAbsence);

  final StudentAbsence studentAbsence;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          'Quantidade de Faltas: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            studentAbsence.quantity?.toString() ?? '0'
          ),
        ),
      ],
    );
  }
}
