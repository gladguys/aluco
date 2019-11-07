import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../save_student_screen.dart';
import '../student_bloc.dart';

class SaveStudentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = BlocProvider.getBloc<StudentBloc>();
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
        final Student studentToSave =
        await ALRouter.push(context, const SaveStudentScreen());
        if (studentToSave != null) {
          await _bloc.save(studentToSave);
        }
      },
    );
  }
}
