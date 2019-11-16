import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';
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

class _SaveLessonPlanFormState extends State<SaveLessonPlanForm> with GGValidators {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('dd-MM-yyyy');

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Data: ${_lessonPlan.lessonDate}'),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Conteúdo',
                initialValue: _lessonPlan.content,
                textInputAction: TextInputAction.done,
                onSaved: (content) => _lessonPlan.content = content,
                minLines: 3,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Metodologia',
                initialValue: _lessonPlan.metodology,
                textInputAction: TextInputAction.done,
                onSaved: (metodology) => _lessonPlan.metodology = metodology,
                minLines: 3,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Atividades de Sala',
                initialValue: _lessonPlan.classwork,
                textInputAction: TextInputAction.done,
                onSaved: (classwork) => _lessonPlan.classwork = classwork,
                minLines: 3,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Atividades de Casa',
                initialValue: _lessonPlan.homework,
                textInputAction: TextInputAction.done,
                onSaved: (homework) => _lessonPlan.homework = homework,
                minLines: 3,
              ),
              FormVerticalSeparator,
              GGOutlinedTextFormField(
                labelText: 'Observações/Notas',
                initialValue: _lessonPlan.notes,
                textInputAction: TextInputAction.done,
                onSaved: (notes) => _lessonPlan.notes = notes,
                minLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
