import 'package:aluco/model/student.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';

import '../class_students_bloc.dart';

class ListClassStudentTile extends StatelessWidget {
  const ListClassStudentTile(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: GGCircleButton(
        icon: Icons.delete,
        colorIcon: Colors.white,
        colorButton: Colors.red[600],
        onTap: () => GGDialog.show(
          context,
          GGConfirmDeleteDialog(
            title: 'Remover aluno da turma?',
            onClickYes: () => BlocProvider.getBloc<ClassStudentsBloc>()
                .unlinkStudentFromClass(student),
          ),
        ),
      ),
    );
  }
}
