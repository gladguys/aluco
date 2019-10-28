import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/save_class_form.dart';

class SaveClassScreen extends StatelessWidget {
  final saveClassForm = SaveClassForm();

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Salvar Turma',
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.save),
          onPressed: () => _onPressedSaveButton(context),
        ),
      ],
      body: Center(
        child: saveClassForm,
      ),
    );
  }

  Future<void> _onPressedSaveButton(BuildContext context) async {
    print('aaaa');
    if (FormUtils.isValid(saveClassForm.form)) {
      print('bbb');
      ALRouter.pop(context, saveClassForm.classForm);
    }
  }
}