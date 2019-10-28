import 'package:aluco/enums/gender.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
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
        size: 42,
      ),
      onTap: () => navigateToEdit(context, _student),
      title: Text(_student.name),
      subtitle: Text(_student?.email ?? ''),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => GGDialog.show(
          context,
          GGConfirmDeleteDialog(
            title: 'Remover estudante?',
            onClickYes: () async =>
                await BlocProvider.of<StudentBloc>(context).delete(_student.id),
          ),
        ),
      ),
      //onPressed: ,
    );
  }

  Future<void> navigateToEdit(BuildContext context, Student student) async {
    final _bloc = BlocProvider.of<StudentBloc>(context);
    final Student studentToSave =
        await ALRouter.push(context, SaveStudentScreen(student));
    if (studentToSave != null) {
      await _bloc.save(studentToSave);
    }
  }
}
