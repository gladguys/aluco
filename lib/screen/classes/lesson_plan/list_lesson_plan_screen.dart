import 'dart:async';

import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/widget/al_scaffold.dart';
import 'package:aluco/widget/al_stream_builder.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gg_flutter_components/loading/gg_loading_double_bounce.dart';

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
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 400,
                      child: Card(
                        child: FutureBuilder<LessonPlan>(
                          future: nextLessonsPlanFuture,
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: GGLoadingDoubleBounce(size: 20));
                            }
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          'Próximo plano:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          snapshot.data.lessonDate,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      snapshot.data.content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Nenhum plano de aula cadastrado.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 400,
                      child: Card(
                        child: FutureBuilder<LessonPlan>(
                          future: lastEditedLessonsPlanFuture,
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(child: GGLoadingDoubleBounce(size: 20));
                            }
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Wrap(
                                      children: <Widget>[
                                        const Text(
                                          'Último plano modificado:',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          snapshot.data.lessonDate,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      snapshot.data.content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return const Padding(
                                padding: EdgeInsets.all(12),
                                child: Text(
                                  'Nenhum plano de aula foi modificado.',
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
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
