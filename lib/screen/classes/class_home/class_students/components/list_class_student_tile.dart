import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/enums/gender.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/screen/classes/class_home/student_info_center/student_info_center_screen.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:line_icons/line_icons.dart';

import '../class_students_bloc.dart';

class ListClassStudentTile extends StatelessWidget {
  const ListClassStudentTile(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        student.gender == Gender.male ? LineIcons.male : LineIcons.female,
        size: 40,
      ),
      title: student.aee ? Text("${student.name} - AEE") : Text(student.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GGCircleButton(
            icon: Icons.info,
            colorIcon: Colors.white,
            colorButton: Colors.blue[600],
            onTap: () =>
                ALRouter.push(context, StudentInfoCenterScreen(student)),
          ),
          const SizedBox(width: 8),
          GGCircleButton(
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
        ],
      ),
    );
  }
}
