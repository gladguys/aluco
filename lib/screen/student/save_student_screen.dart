import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/student.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

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
      title: 'Adicionar Aluno',
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 18),
          _saveStudentForm
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.done),
        label: const Text(
          'Confirmar',
          style: TextStyle(
            fontSize: 16,
            letterSpacing: 0,
          ),
        ),
        backgroundColor: Colors.green[600],
        onPressed: () => _onPressedSaveButton(context),
      ),
    );
  }

  Future<void> _onPressedSaveButton(BuildContext context) async {
    if (FormUtils.isValid(_saveStudentForm.form)) {
      ALRouter.pop(context, _saveStudentForm.studentForm);
    }
  }
}
