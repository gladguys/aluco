import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_random_circle_avatar.dart';

import 'components/save_student_form.dart';

class SaveStudentScreen extends StatefulWidget {
  const SaveStudentScreen([this.student]);

  final Student student;

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
      title: 'Salvar Aluno',
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
    if (FormUtils.isValid(_saveStudentForm.form)) {
      ALRouter.pop(context, _saveStudentForm.studentForm);
    }
  }
}
