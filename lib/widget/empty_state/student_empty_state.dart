import 'package:aluco/screen/student/components/save_student_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StudentEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Icon(Icons.not_interested, size: 120, color: Colors.grey[300],),
              const SizedBox(height: 32),
              const Text('Você ainda não cadastrou nenhuma estudante', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              SaveStudentButton(),
            ],
          ),
        ),
      ),
    );
  }
}
