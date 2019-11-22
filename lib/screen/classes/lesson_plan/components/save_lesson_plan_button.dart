import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../save_lesson_plan_screen.dart';

class SaveLessonPlanButton extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<ClassHomeBloc>();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: const Text(
        'Adicionar',
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Theme.of(context).accentColor,
      onPressed: () async {
        final LessonPlan lessonPlan = await ALRouter.push(context, const SaveLessonPlanScreen());
        if (lessonPlan != null) {
          await _bloc.saveLessonPlan(lessonPlan);
        }
      },
    );
  }
}
