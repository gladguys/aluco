import 'package:aluco/model/exam.dart';
import 'package:aluco/widget/gg_form_date_picker.dart';
import 'package:aluco/widget/gg_outlined_text_form_field.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sujian_select/select_group.dart';
import 'package:flutter_sujian_select/select_item.dart';
import 'package:gg_flutter_components/validator/gg_validators.dart';
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
  final dateFormat = DateFormat('dd/MM/yyyy');
  bool weightVisible = true;

  Exam _exam;

  @override
  void initState() {
    super.initState();
    if (widget._exam != null) {
      _exam = widget._exam;
      if (_exam.recExam) {
        weightVisible = false;
      }
    } else {
      _exam = Exam()
        ..weight = 1
        ..periodYear = 1
        ..recExam = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: <Widget>[
              GGOutlinedTextFormField(
                labelText: 'Nome *',
                initialValue: _exam.name,
                textInputAction: TextInputAction.done,
                onSaved: (name) => _exam.name = name,
                validator: emptyValidator,
              ),
              GGOutlinedTextFormField(
                labelText: 'Descrição *',
                width: 400,
                initialValue: _exam.description,
                textInputAction: TextInputAction.done,
                onSaved: (description) => _exam.description = description,
                validator: emptyValidator,
              ),
              GGFormDatePicker(
                labelText: 'Data da Prova *',
                width: 240,
                format: dateFormat,
                initialDate: _exam.examDate != null
                    ? dateFormat.parse(_exam.examDate)
                    : null,
                validator: (examDate) {
                  if (_exam.examDate == null && examDate == null) {
                    return 'Campo Obrigatório';
                  }
                  if (_exam.examDate == null) {
                    final firstValidation = emptyDateTimeValidator(examDate);
                    if (firstValidation == null) {
                      return 'Campo Obrigatório';
                    } else {
                      return firstValidation;
                    }
                  }
                  return null;
                },
                onChanged: (examDate) {
                  if (examDate != null) {
                    _exam.examDate = dateFormat?.format(examDate);
                  } else {
                    _exam.examDate = null;
                  }
                },
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularCheckBox(
                      value: _exam.recExam,
                      onChanged: (isRecExam) {
                        _exam.recExam = isRecExam;
                        if (isRecExam) {
                          checkIfCanSetRecover();
                        } else {
                          setState(() {
                            _exam.recExam = isRecExam;
                            weightVisible = !isRecExam;
                            if (isRecExam) {
                              _exam.weight = 1;
                            }
                          });
                        }
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                    const Text('Recuperação? '),
                  ],
                ),
              ),
              if (weightVisible)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Peso da Prova: '),
                    SelectGroup<int>(
                      index: _exam.weight - 1,
                      selectColor: Theme.of(context).primaryColor,
                      borderColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.all(16),
                      space: const EdgeInsets.symmetric(horizontal: 4),
                      items: <SelectItem<int>>[
                        SelectItem(label: '1', value: 1),
                        SelectItem(label: '2', value: 2),
                        SelectItem(label: '3', value: 3),
                      ],
                      onSingleSelect: (int value) => _exam.weight = value,
                    ),
                  ],
                )
              else
                const SizedBox(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Bimestre: '),
                  SelectGroup<int>(
                    index: _exam.periodYear - 1,
                    selectColor: Theme.of(context).primaryColor,
                    borderColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.all(16),
                    space: const EdgeInsets.symmetric(horizontal: 4),
                    items: <SelectItem<int>>[
                      SelectItem(label: '1', value: 1),
                      SelectItem(label: '2', value: 2),
                      SelectItem(label: '3', value: 3),
                      SelectItem(label: '4', value: 4),
                    ],
                    onSingleSelect: (periodYear) {
                      setState(() {
                        _exam.periodYear = periodYear;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool hasAnyRecover(List<Exam> exams) {
    return exams.indexWhere((exam) => exam.recExam) != -1;
  }
}
