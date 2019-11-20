import 'package:aluco/model/exam.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_basic_yn_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_info_dialog.dart';
import 'package:intl/intl.dart';

import '../exam_bloc.dart';
import '../exam_detail_screen.dart';
import '../save_exam_screen.dart';

class ExamTile extends StatelessWidget {
  const ExamTile(this.exam);

  final Exam exam;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(exam.name ?? ''),
      subtitle: Text(exam.examDate?.toString() ?? ''),
      onTap: () {
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
        EditExamButton(exam),
        GGCircleButton(
          icon: Icons.delete,
          colorIcon: Colors.white,
          colorButton: Colors.red[600],
          onTap: () => GGDialog.show(
            context,
            GGConfirmDeleteDialog(
              title: 'Remover prova?',
              onClickYes: () async =>
                  BlocProvider.getBloc<ExamBloc>().delete(exam),
            ),
          ),
        ),
      ],
    );
  }
}

class EditExamButton extends StatelessWidget {
  EditExamButton(this.exam);

  final Exam exam;
  final dateFormat = DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    final nowString = dateFormat.format(DateTime.now());
    final isExpired =
        dateFormat.parse(exam.examDate).isBefore(dateFormat.parse(nowString));

    return GGCircleButton(
      icon: Icons.edit,
      colorIcon: Colors.white,
      colorButton: isExpired ? Colors.grey[600] : Colors.blue[600],
      onTap: isExpired
          ? () => _showExpiredDialog(context)
          : () => _navigateToEdit(context, exam),
    );
  }

  void _showExpiredDialog(BuildContext context) {
    GGDialog.show(
      context,
      GGInfoDialog(
        title: 'Edição de prova não permitida',
        text:
            'Esta prova foi concluída na data ${exam.examDate}. Não é possível editar informações de provas passadas.',
      ),
    );
  }

  Future<void> _navigateToEdit(BuildContext context, Exam exam) async {
    final Exam examToSave = await ALRouter.push(context, SaveExamScreen(exam));
    final classId = BlocProvider.getBloc<ClassHomeBloc>().pickedClass.id;
    if (examToSave != null) {
      await BlocProvider.getBloc<ExamBloc>().save(examToSave, classId);
    }
  }
}
