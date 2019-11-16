import 'package:aluco/model/lesson_plan.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
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
  final dateFormat = DateFormat('dd-MM-yyyy');
  CalendarController _calendarController;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      locale: 'pt_BR',
      events: _buildLessonsMap(widget.lessonsPlans),
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      headerStyle: const HeaderStyle(centerHeaderTitle: true),
      onDayLongPressed: (date, _) => _onDayLongPressed(date, _),
      onDaySelected: (date, _) => _onDaySelected(date, _)
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
          onClickYes: () async => await _bloc.deleteLessonPlan(lessonPlanDelete),
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
