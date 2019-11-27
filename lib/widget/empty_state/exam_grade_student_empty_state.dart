import 'package:aluco/screen/classes/class_home/class_students/components/add_student_class_button.dart';
import 'package:flutter/material.dart';

class ExamGradeStudentEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Você ainda não adicionou nenhum aluno a esta turma.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 48),
            AddStudentClassButton(isFloating: false),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
