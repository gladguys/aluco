import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_random_circle_avatar.dart';

import 'components/save_student_form.dart';
import 'student_bloc.dart';

class SaveStudentScreen extends StatefulWidget {
  const SaveStudentScreen({
    this.blocContext,
    this.student
  });

  final Student student;
  final BuildContext blocContext;

  @override
  _SaveStudentScreen createState() => _SaveStudentScreen();
}

class _SaveStudentScreen extends State<SaveStudentScreen> {
  SaveStudentForm _saveStudentForm;

  @override
  void initState() {
    _saveStudentForm = SaveStudentForm(widget.student);
    super.initState();
  }

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
          _saveStudentForm
        ],
      ),
    );
  }

  Future<void> _onPressedSaveButton(BuildContext context) async {
    final _bloc = BlocProvider.of<StudentBloc>(widget.blocContext);
    if (FormUtils.isValid(_saveStudentForm.form)) {
      await _bloc.saveStudent(_saveStudentForm.studentForm);
      ALRouter.pop(context);
    }
  }
}
