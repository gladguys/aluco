import 'package:aluco/model/class.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/save_class_form.dart';

class SaveClassScreen extends StatefulWidget {
  const SaveClassScreen([this.classe]);

  final Class classe;

  @override
  _SaveClassScreenState createState() => _SaveClassScreenState();
}

class _SaveClassScreenState extends State<SaveClassScreen> {
  SaveClassForm _saveClassForm;

  @override
  void initState() {
    _saveClassForm = SaveClassForm(widget.classe);
    super.initState();
  }

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
        child: _saveClassForm,
      ),
    );
  }

  Future<void> _onPressedSaveButton(BuildContext context) async {
    if (FormUtils.isValid(_saveClassForm.form)) {
      ALRouter.pop(context, _saveClassForm.classForm);
    }
  }
}