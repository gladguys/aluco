import 'package:aluco/model/student.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';

class ListClassStudentTile extends StatelessWidget {
  const ListClassStudentTile(this.student);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: GestureDetector(
        child: Icon(Icons.delete),
        onTap: () => GGDialog.show(
          context,
          GGConfirmDeleteDialog(
            title: 'Remover aluno da turma?',
            onClickYes: () => print('DELETAR AQUI'),
          ),
        ),
      ),
    );
  }
}
