import 'package:aluco/model/exam.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../exam_bloc.dart';
import '../save_exam_screen.dart';

class SaveExamButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: const Text(
        'Adicionar',
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).accentColor,
      onPressed: () async {
        final Exam exam =
        await ALRouter.push(context, const SaveExamScreen());
        if (exam != null) {
          await BlocProvider.getBloc<ExamBloc>().save(exam);
        }
      },
    );
  }
}