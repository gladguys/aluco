import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';

import 'components/save_lesson_plan_form.dart';

class SaveLessonPlanScreen extends StatefulWidget {
  const SaveLessonPlanScreen({this.lessonPlan, this.date});

  final LessonPlan lessonPlan;
  final DateTime date;

  @override
  _SaveLessonPlanScreenState createState() => _SaveLessonPlanScreenState();
}

class _SaveLessonPlanScreenState extends State<SaveLessonPlanScreen> {
  SaveLessonPlanForm _saveLessonPlanForm;

  @override
  void initState() {
    _saveLessonPlanForm = SaveLessonPlanForm(widget.lessonPlan, widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Adicionar Plano',
      body: ListView(
        children: <Widget>[const SizedBox(height: 18), _saveLessonPlanForm],
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
    if (FormUtils.isValid(_saveLessonPlanForm.form)) {
      ALRouter.pop(context, _saveLessonPlanForm.examForm);
    }
  }
}
