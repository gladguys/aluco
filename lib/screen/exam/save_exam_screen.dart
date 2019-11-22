import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/exam.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/save_exam_form.dart';

class SaveExamScreen extends StatefulWidget {
  const SaveExamScreen([this.exam]);

  final Exam exam;

  @override
  _SaveExamScreen createState() => _SaveExamScreen();
}

class _SaveExamScreen extends State<SaveExamScreen> {
  SaveExamForm _saveExamForm;

  @override
  void initState() {
    _saveExamForm = SaveExamForm(widget.exam);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Adicionar Prova',
      body: ListView(
        children: <Widget>[
          const SizedBox(height: 18),
          _saveExamForm
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
    if (FormUtils.isValid(_saveExamForm.form)) {
      ALRouter.pop(context, _saveExamForm.examForm);
    }
  }
}
