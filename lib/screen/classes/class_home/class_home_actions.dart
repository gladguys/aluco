import 'package:aluco/model/class.dart';
import 'package:aluco/screen/classes/call/call_bloc.dart';
import 'package:aluco/screen/classes/call/call_screen.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_screen.dart';
import 'package:aluco/screen/classes/grade_board/grade_board_screen.dart';
import 'package:aluco/screen/classes/lesson_plan/list_lesson_plan_screen.dart';
import 'package:aluco/screen/exam/exam_bloc.dart';
import 'package:aluco/screen/exam/exams_screen.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'class_home_bloc.dart';

class ClassHomeActions extends StatelessWidget {
  final _classBloc = BlocProvider.getBloc<ClassHomeBloc>();

  Class get classe => _classBloc.pickedClass;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            children: <Widget>[
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'users',
                  weight: IconWeight.Solid,
                ),
                text: 'Alunos da Turma',
                route: ClassStudentsScreen(),
              ),
              if (classe.classStatus == ClassStatus.started)
                ALIconTextVerticalButton(
                  icon: FontAwesome5.getIconData(
                    'history',
                    weight: IconWeight.Solid,
                  ),
                  text: 'Chamadas',
                  route: CallScreen(),
                  resolver: () => BlocProvider.getBloc<CallBloc>()
                      .initializeClassStudentsFromDate(
                    _classBloc.pickedClass.id,
                    DateTime.now(),
                  ),
                )
              else
                const SizedBox.shrink(),
              if (classe.classStatus == ClassStatus.started)
                ALIconTextVerticalButton(
                  icon: FontAwesome5.getIconData(
                    'clipboard-list',
                    weight: IconWeight.Solid,
                  ),
                  text: 'Quadro de Notas',
                  route: GradeBoardScreen(),
                )
              else
                const SizedBox.shrink(),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'book',
                  weight: IconWeight.Solid,
                ),
                text: 'Planos de Aulas',
                route: ListLessonPlanScreen(),
                resolver: () => BlocProvider.getBloc<ClassHomeBloc>()
                    .initializeClassPlannedLessons(),
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'file-alt',
                  weight: IconWeight.Solid,
                ),
                text: 'Provas',
                route: ExamsScreen(),
                resolver: () => BlocProvider.getBloc<ExamBloc>()
                    .getExamsByClass(_classBloc.pickedClass.id),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
