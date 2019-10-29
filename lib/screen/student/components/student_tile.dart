import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_basic_yn_dialog.dart';

import '../save_student_screen.dart';

class StudentTile extends StatelessWidget {
  const StudentTile(this._student);

  final Student _student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ValueKey(_student.id),
      leading: AvataaarImage(
        avatar: Avataaar.random(),
        errorImage: Icon(Icons.error),
        placeholder: const CircularProgressIndicator(),
        width: 128,
      ),
      onTap: () => navigateToEdit(context, _student),
      title: Text(_student.name),
      subtitle: Text(_student?.email ?? ''),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => showConfirmationDialog(context),
      ),
      //onPressed: ,
    );
  }

  Future<void> navigateToEdit(BuildContext context, Student student) async {
    final _bloc = BlocProvider.of<StudentBloc>(context);
    final Student studentToSave =
        await ALRouter.push(context, SaveStudentScreen(student));
    if (studentToSave != null) {
      await _bloc.saveStudent(studentToSave);
    }
  }

  void showConfirmationDialog(BuildContext context) {
    final _bloc = BlocProvider.of<StudentBloc>(context);
    showDialog<GGBasicYNDialog>(
      context: context,
      builder: (BuildContext context) => GGBasicYNDialog(
        title: 'Remover estudante?',
        text: 'Esta ação é irreversível. Você tem certeza?',
        onClickYes: () async => await _bloc.deleteStudent(_student.id),
      ),
    );
  }
}
