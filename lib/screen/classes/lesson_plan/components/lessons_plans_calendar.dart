import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../save_lesson_plan_screen.dart';

class LessonsPlansCalendar extends StatefulWidget {
  const LessonsPlansCalendar(this.lessonsPlans);

  final List<LessonPlan> lessonsPlans;

  @override
  _LessonsPlansCalendarState createState() => _LessonsPlansCalendarState();
}

class _LessonsPlansCalendarState extends State<LessonsPlansCalendar> {
  final _bloc = BlocProvider.getBloc<ClassHomeBloc>();
  final dateFormat = DateFormat('dd/MM/yyyy');
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey[300]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: TableCalendar(
          calendarController: _calendarController,
          locale: 'pt_BR',
          events: _buildLessonsMap(widget.lessonsPlans),
          availableCalendarFormats: const {
            CalendarFormat.week: 'Semana',
            CalendarFormat.month: 'Mês',
          },
          headerStyle: HeaderStyle(
            headerPadding: null,
            formatButtonTextStyle: TextStyle(color: Colors.grey[600]),
            formatButtonDecoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey),
                left: BorderSide(color: Colors.grey),
                right: BorderSide(color: Colors.grey),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            titleTextBuilder: (DateTime date, dynamic locale) =>
                DateFormat.yMMM(locale).format(date),
          ),
          builders: CalendarBuilders(
            dayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: Colors.grey[400],
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.1),
                      color: Colors.grey[300],
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: const TextStyle().copyWith(fontSize: 14),
                  ),
                ),
              );
            },
            outsideDayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: const TextStyle().copyWith(
                      fontSize: 14,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              );
            },
            outsideWeekendDayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: const TextStyle().copyWith(
                      fontSize: 14,
                      color: Colors.red[100],
                    ),
                  ),
                ),
              );
            },
            todayDayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: (date.weekday == 6 || date.weekday == 7)
                          ? Colors.red[100]
                          : Colors.grey[400],
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.1),
                      color: (date.weekday == 6 || date.weekday == 7)
                          ? Colors.red[50]
                          : Colors.grey[300],
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: (date.weekday == 6 || date.weekday == 7)
                        ? const TextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[300])
                        : const TextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                ),
              );
            },
            weekendDayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(0, 1),
                      color: Colors.red[100],
                    ),
                    BoxShadow(
                      offset: const Offset(0, -0.1),
                      color: Colors.red[50],
                    )
                  ],
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: const TextStyle().copyWith(
                      fontSize: 14.0,
                      color: Colors.red[300],
                    ),
                  ),
                ),
              );
            },
            selectedDayBuilder: (context, date, list) {
              return Container(
                margin: const EdgeInsets.all(4),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2,
                    color: Colors.orange[600],
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    '${date.day}',
                    style: (date.weekday == 6 || date.weekday == 7) &&
                            _calendarController.isToday(date)
                        ? const TextStyle().copyWith(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[300])
                        : (date.weekday == 6 || date.weekday == 7)
                            ? const TextStyle().copyWith(
                                fontSize: 14.0, color: Colors.red[300])
                            : _calendarController.isToday(date)
                                ? const TextStyle().copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  )
                                : const TextStyle().copyWith(fontSize: 14.0),
                  ),
                ),
              );
            },
            markersBuilder: (context, date, events, holidays) {
              final children = <Widget>[];

              if (events.isNotEmpty) {
                children.add(
                  Center(
                    child: _buildEventsMarker(date, events),
                  ),
                );
              }

              return children;
            },
          ),
          onDayLongPressed: (date, _) => _onDayLongPressed(date, _),
          onDaySelected: (date, _) => _onDaySelected(date, _),
        ),
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.primaryColorLight,
        border: _calendarController.isSelected(date)
            ? Border.all(width: 2, color: Colors.orange[600])
            : null,
        borderRadius: BorderRadius.circular(50),
        boxShadow: _calendarController.isSelected(date)
            ? null
            : <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.orange[300],
                ),
                BoxShadow(
                  offset: const Offset(0, -0.1),
                  color: Colors.orange[200],
                )
              ],
      ),
      child: Center(
        child: Text(
          '${date.day}',
          style: (_calendarController.isToday(date) ||
                      _calendarController.isSelected(date)) &&
                  (date.weekday == 6 || date.weekday == 7)
              ? const TextStyle().copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[300])
              : const TextStyle().copyWith(fontSize: 14.0),
        ),
      ),
    );
  }

  Future<void> _onDaySelected(DateTime date, List<dynamic> _) async {
    final lessonPlanEdit = _bloc.getLessonPlanFromDate(date);
    final LessonPlan lessonPlanSave = await ALRouter.push(
      context,
      SaveLessonPlanScreen(lessonPlan: lessonPlanEdit, date: date),
    );
    if (lessonPlanSave != null) {
      await _bloc.saveLessonPlan(lessonPlanSave);
    }
  }

  Future<void> _onDayLongPressed(DateTime date, List<dynamic> _) async {
    final lessonPlanDelete = _bloc.getLessonPlanFromDate(date);
    if (lessonPlanDelete != null) {
      GGDialog.show(
        context,
        GGConfirmDeleteDialog(
          title: 'Remover plano de aula?',
          onClickYes: () async =>
              await _bloc.deleteLessonPlan(lessonPlanDelete),
        ),
      );
    }
  }

  Map<DateTime, List> _buildLessonsMap(List<LessonPlan> lessonsPlans) {
    final Map<DateTime, List> lessonsMap = {};
    for (LessonPlan lessonPlan in lessonsPlans) {
      lessonsMap.putIfAbsent(
          dateFormat.parse(lessonPlan.lessonDate), () => <dynamic>['']);
    }
    return lessonsMap;
  }
}
