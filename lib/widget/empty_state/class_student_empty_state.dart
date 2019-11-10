import 'package:aluco/screen/classes/class_home/class_students/components/add_student_class_button.dart';
import 'package:flutter/material.dart';

class ClassStudentEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(
                Icons.not_interested,
                size: 120,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 32),
              const Text(
                'Você ainda não vinculou nenhum aluno a esta turma',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              AddStudentClassButton(),
            ],
          ),
        ),
      ),
    );
  }
}
