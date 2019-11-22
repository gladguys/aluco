import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/class.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SaveClassForm extends StatefulWidget {
  SaveClassForm([this.classe]);

  final Class classe;

  FormState get form => _saveClassState._formKey.currentState;
  Class get classForm => _saveClassState._class;

  final _saveClassState = _SaveClassFormState();

  @override
  _SaveClassFormState createState() => _saveClassState;
}

class _SaveClassFormState extends State<SaveClassForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  Class _class;

  @override
  void initState() {
    super.initState();
    if (widget.classe != null) {
      _class = widget.classe;
    } else {
      _class = Class();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            GGOutlinedTextFormField(
              labelText: 'Nome',
              initialValue: _class.name,
              onSaved: (name) => _class.name = name,
              validator: (name) => emptyValidator(name.trim()),
            ),
            FormVerticalSeparator,
            GGOutlinedTextFormField(
              labelText: 'Descrição',
              initialValue: _class.description,
              onSaved: (description) => _class.description = description,
            ),
          ],
        ),
      ),
    );
  }
}
