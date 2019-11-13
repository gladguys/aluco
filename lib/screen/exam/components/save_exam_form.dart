import 'package:aluco/model/exam.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sujian_select/select_group.dart';
import 'package:flutter_sujian_select/select_item.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
import 'package:intl/intl.dart';

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
  final dateFormat = DateFormat('dd-MM-yyyy');

  Exam _exam;

  @override
  void initState() {
    super.initState();
    if (widget._exam != null) {
      _exam = widget._exam;
    } else {
      _exam = Exam()..weight = 1;
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
              FormVerticalSeparator,
              GGFormDatePicker(
                labelText: 'Data da Prova',
                format: dateFormat,
                initialDate: _exam.examDate != null ? dateFormat.parse(_exam.examDate) : null,
                onChanged: (examDate) {
                  if (examDate != null) {
                    _exam.examDate = dateFormat?.format(examDate);
                  }
                },
              ),
              FormVerticalSeparator,
              Row(
                children: <Widget>[
                  const Text('Peso da Prova'),
                  const SizedBox(width: 32),
                  SelectGroup<int>(
                    index: _exam.weight - 1,
                    selectColor: Theme.of(context).primaryColor,
                    borderColor: Colors.white,
                    padding: const EdgeInsets.all(14),
                    space: const EdgeInsets.all(8),
                    items: <SelectItem<int>>[
                      SelectItem(label: '1',value: 1),
                      SelectItem(label: '2',value: 2),
                      SelectItem(label: '3',value: 3),
                    ],
                    onSingleSelect: (int value) => _exam.weight = value,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
