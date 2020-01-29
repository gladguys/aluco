import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/core/utils/form_utils.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/repository/api/lesson_plan_repository.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/save_lesson_plan_form.dart';

class SaveLessonPlanScreen extends StatefulWidget {
  const SaveLessonPlanScreen({this.lessonPlan, this.date, this.lessonPlanId});

  final LessonPlan lessonPlan;
  final DateTime date;
  final int lessonPlanId;

  @override
  _SaveLessonPlanScreenState createState() => _SaveLessonPlanScreenState();
}

class _SaveLessonPlanScreenState extends State<SaveLessonPlanScreen> {
  SaveLessonPlanForm _saveLessonPlanForm;
  LessonPlan lessonPlan;
  bool isLoading = false;
  final _lessonRepository = G<LessonPlanRepository>();
  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    if (widget.lessonPlanId != null) {
      setState(() {
        isLoading = true;
      });
      loadLessonPlan(widget.lessonPlanId);
    }
    _saveLessonPlanForm = SaveLessonPlanForm(widget.lessonPlan, widget.date);
    super.initState();
  }

  Future<void> loadLessonPlan(int id) async {
    final lessonPlan = await _lessonRepository.getById(id);
    final lessonPlanDate = dateFormat.parse(lessonPlan.lessonDate);
    setState(() {
      _saveLessonPlanForm = SaveLessonPlanForm(lessonPlan, lessonPlanDate);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ALScaffold(
      title: 'Adicionar Plano',
      body: isLoading
          ? Container()
          : ListView(
              children: <Widget>[
                const SizedBox(height: 18),
                _saveLessonPlanForm
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
    if (FormUtils.isValid(_saveLessonPlanForm.form)) {
      ALRouter.pop(context, _saveLessonPlanForm.examForm);
    }
  }
}
