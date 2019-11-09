import 'package:aluco/model/exam.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

class SaveExamForm extends StatefulWidget {
  SaveExamForm(this._exam);

  final Exam _exam;

  FormState get form => _saveExamState._formKey.currentState;
  Exam get examForm => _saveExamState._exam;

  final _saveExamState = _SaveExamFormState();

  @override
  _SaveExamFormState createState() => _saveExamState;
}

class _SaveExamFormState extends State<SaveExamForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  Exam _exam;

  @override
  void initState() {
    super.initState();
    if (widget._exam != null) {
      _exam = widget._exam;
    } else {
      _exam = Exam();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GGOutlinedTextFormField(
                labelText: 'Nome *',
                initialValue: _exam.name,
                textInputAction: TextInputAction.done,
                onSaved: (name) => _exam.name = name,
                validator: emptyValidator,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Descrição *',
                initialValue: _exam.description,
                textInputAction: TextInputAction.done,
                onSaved: (description) => _exam.description = description,
                validator: emptyValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
