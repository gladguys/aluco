import 'package:aluco/enums/gender.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/button/gg_circle_button.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:line_icons/line_icons.dart';

import '../save_student_screen.dart';

class StudentTile extends StatelessWidget {
  const StudentTile(this._student);

  final Student _student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(_student.id),
      leading: Icon(
        _student.gender == Gender.male ? LineIcons.male : LineIcons.female,
        size: 40,
      ),
      onTap: () => navigateToEdit(context, _student),
      title: Text(_student.name),
      subtitle: Text(_student.email ?? ''),
      trailing: GGCircleButton(
        icon: Icons.delete,
        colorIcon: Colors.white,
        colorButton: Colors.red[600],
        onTap: () => GGDialog.show(
          context,
          GGConfirmDeleteDialog(
            title: 'Remover aluno?',
            onClickYes: () async =>
                await BlocProvider.getBloc<StudentBloc>().delete(_student),
          ),
        ),
      ),
      //onPressed: ,
    );
  }

  Future<void> navigateToEdit(BuildContext context, Student student) async {
    final Student studentToSave =
        await ALRouter.push(context, SaveStudentScreen(student));
    if (studentToSave != null) {
      await BlocProvider.getBloc<StudentBloc>().save(studentToSave);
    }
  }
}
