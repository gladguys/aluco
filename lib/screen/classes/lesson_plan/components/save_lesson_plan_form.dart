import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/widget/gg_outlined_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/validator/gg_validators.dart';
import 'package:intl/intl.dart';

class SaveLessonPlanForm extends StatefulWidget {
  SaveLessonPlanForm(this._lessonPlan, this.date);

  final LessonPlan _lessonPlan;
  final DateTime date;

  FormState get form => _saveLessonPlanState._formKey.currentState;
  LessonPlan get examForm => _saveLessonPlanState._lessonPlan;

  final _saveLessonPlanState = _SaveLessonPlanFormState();

  @override
  _SaveLessonPlanFormState createState() => _saveLessonPlanState;
}

class _SaveLessonPlanFormState extends State<SaveLessonPlanForm>
    with GGValidators {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  LessonPlan _lessonPlan;

  @override
  void initState() {
    super.initState();
    if (widget._lessonPlan != null) {
      _lessonPlan = widget._lessonPlan;
    } else {
      _lessonPlan = LessonPlan()..lessonDate = dateFormat.format(widget.date);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Data: ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text('${_lessonPlan.lessonDate}'),
                ],
              ),
              GGOutlinedTextFormField(
                labelText: 'Conteúdo',
                width: 400,
                initialValue: _lessonPlan.content,
                textInputAction: TextInputAction.newline,
                onSaved: (content) => _lessonPlan.content = content,
                minLines: 3,
              ),
              GGOutlinedTextFormField(
                labelText: 'Metodologia',
                width: 400,
                initialValue: _lessonPlan.metodology,
                textInputAction: TextInputAction.newline,
                onSaved: (metodology) => _lessonPlan.metodology = metodology,
                minLines: 3,
              ),
              GGOutlinedTextFormField(
                labelText: 'Atividades de Sala',
                width: 400,
                initialValue: _lessonPlan.classwork,
                textInputAction: TextInputAction.newline,
                onSaved: (classwork) => _lessonPlan.classwork = classwork,
                minLines: 3,
              ),
              GGOutlinedTextFormField(
                labelText: 'Atividades de Casa',
                width: 400,
                initialValue: _lessonPlan.homework,
                textInputAction: TextInputAction.newline,
                onSaved: (homework) => _lessonPlan.homework = homework,
                minLines: 3,
              ),
              GGOutlinedTextFormField(
                labelText: 'Observações/Notas',
                width: 400,
                initialValue: _lessonPlan.notes,
                textInputAction: TextInputAction.newline,
                onSaved: (notes) => _lessonPlan.notes = notes,
                minLines: 3,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
