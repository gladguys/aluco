import 'package:aluco/screen/exam/components/save_exam_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ExamEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Você ainda não cadastrou nenhuma prova.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 48),
              SaveExamButton(isFloating: false),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
