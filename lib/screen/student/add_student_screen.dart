import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_random_circle_avatar.dart';

import 'components/add_student_form.dart';
import 'student_bloc.dart';

class AddStudentScreen extends StatelessWidget {
  final _bloc = StudentBloc();
  final _addStudentForm = AddStudentForm();

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Adicionar Aluno',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () => _onPressedSaveButton(context),
        ),
      ],
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 18),
          GGRandomCircleAvatar(radius: 50),
          _addStudentForm
        ],
      ),
    );
  }

  Future<void> _onPressedSaveButton(BuildContext context) async {
    final form = _addStudentForm.form;
    if (FormUtils.isValid(_addStudentForm.form)) {
      form.save();
      await _bloc.saveStudent(_addStudentForm.student);
      ALRouter.pop(context);
    }
  }
}
