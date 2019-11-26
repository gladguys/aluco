import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:intl/intl.dart';

import '../exam_bloc.dart';
import '../exam_detail_screen.dart';
import '../save_exam_screen.dart';

class ExamTile extends StatelessWidget {
  ExamTile(this.exam);

  final Exam exam;
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exam.name ?? ''),
      subtitle: Text(DateFormat('d MMM y', 'pt_br').format(dateFormat.parse(exam.examDate)) ?? ''),
      onTap: ()  {
        BlocProvider.getBloc<ExamBloc>().pickExam(exam);
        ALRouter.push(context, ExamDetailScreen(exam));
      },
      trailing: ExamActions(exam),
    );
  }
}

class ExamActions extends StatelessWidget {
  const ExamActions(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: <Widget>[
        GGCircleButton(
          icon: Icons.edit,
          colorIcon: Colors.white,
          colorButton: Colors.blue[600],
          onTap: () => navigateToEdit(context, exam),
        ),
        GGCircleButton(
          icon: Icons.delete,
          colorIcon: Colors.white,
          colorButton: Colors.red[600],
          onTap: () => GGDialog.show(
            context,
            GGConfirmDeleteDialog(
              title: 'Remover prova?',
              onClickYes: () async => BlocProvider.getBloc<ExamBloc>().delete(exam),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> navigateToEdit(BuildContext context, Exam exam) async {
    final Exam examToSave = await ALRouter.push(context, SaveExamScreen(exam));
    final classId = BlocProvider.getBloc<ClassHomeBloc>().pickedClass.id;
    if (examToSave != null) {
      await BlocProvider.getBloc<ExamBloc>().save(examToSave, classId);
    }
  }
}
