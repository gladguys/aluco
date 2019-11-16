import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import 'components/lessons_plans_calendar.dart';

class ListLessonPlanScreen extends StatelessWidget {
  final _bloc = BlocProvider.getBloc<ClassHomeBloc>();

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<LessonPlan>>(
      stream: _bloc.classPlannedLessonsController.stream,
      mainWidget: (dynamic lessonsPlans) => ALScaffold(
        title: 'Planos de Aula',
        body: Column(
          children: <Widget>[
            LessonsPlansCalendar(lessonsPlans),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  '* pressione um dia para adicionar ou modificar um plano de aula',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                Text(
                  '* pressione um dia por mais tempo para deletar um plano de aula',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
