import 'dart:async';

import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'components/lessons_plans_calendar.dart';

class ListLessonPlanScreen extends StatefulWidget {
  @override
  _ListLessonPlanScreenState createState() => _ListLessonPlanScreenState();
}

class _ListLessonPlanScreenState extends State<ListLessonPlanScreen> {
  final _bloc = BlocProvider.getBloc<ClassHomeBloc>();
  Future<LessonPlan> nextLessonsPlanFuture;
  Future<LessonPlan> lastEditedLessonsPlanFuture;

  @override
  void initState() {
    final int classId = _bloc.pickedClass.id;
    nextLessonsPlanFuture = _bloc.getNextLessonsPlan(classId);
    lastEditedLessonsPlanFuture = _bloc.getLastEditedLessonsPlan(classId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ALStreamBuilder<List<LessonPlan>>(
      stream: _bloc.classPlannedLessonsController.stream,
      mainWidget: (dynamic lessonsPlans) => ALScaffold(
        title: 'Planos de Aula',
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              LessonsPlansCalendar(lessonsPlans),
              const SizedBox(height: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FutureBuilder<LessonPlan>(
                    future: nextLessonsPlanFuture,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Próximo Plano de Aula',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(snapshot.data.lessonDate),
                              Text(snapshot.data.content,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(22),
                          child: Text('Nenhum plano de aula cadastrado.'),
                        );
                      }
                    },
                  ),
                  FutureBuilder<LessonPlan>(
                    future: lastEditedLessonsPlanFuture,
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            children: <Widget>[
                              const Text(
                                'Último Plano de Aula modificado',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(snapshot.data.lessonDate),
                              Text(snapshot.data.content,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text('Nenhum plano de aula foi modificado.'),
                        );
                      }
                    },
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
