import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/student/student_bloc.dart';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

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
      title: Text(_student.name),
      subtitle: Text(_student?.email ?? ''),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () => showConfirmationDialog(context),
      ),
      //onPressed: ,
    );
  }

  // TODO(rodrigo): transform in components on ggfc (and more)
  void showConfirmationDialog(BuildContext context) {
    final _bloc = BlocProvider.of<StudentBloc>(context);
    showDialog<NAlertDialog>(
      context: context,
      builder: (BuildContext context) => NAlertDialog(
        dialogStyle: DialogStyle(titleDivider: true),
        title: const Text('Remover estudante?'),
        content:
        const Text('Esta ação é irreversível. Você tem certeza?'),
        actions: <Widget>[
          FlatButton(
            child: const Text('Não'),
            onPressed: () => ALRouter.pop(context),
          ),
          FlatButton(
            child: const Text('Sim'),
            onPressed: () async {
              await _bloc.deleteStudent(_student.id);
              ALRouter.pop(context);
            },
          )
        ],
      ),
    );
  }
}
