import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/model/class.dart';
import 'package:aluco/screen/classes/call/call_bloc.dart';
import 'package:aluco/screen/classes/call/call_screen.dart';
import 'package:aluco/screen/classes/class_home/class_students/class_students_screen.dart';
import 'package:aluco/screen/classes/grade_board/grade_board_screen.dart';
import 'package:aluco/screen/classes/lesson_plan/list_lesson_plan_screen.dart';
import 'package:aluco/screen/exam/exam_bloc.dart';
import 'package:aluco/screen/exam/exams_screen.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:aluco/widget/al_icon_text_vertical_button.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:gg_flutter_components/dialog/gg_basic_yn_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_confirm_delete_dialog.dart';
import 'package:gg_flutter_components/dialog/gg_dialog.dart';
import 'package:gg_flutter_components/gg_flutter_components.dart';

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
              GGIconLabelContainer(
                icon: Icon(
                  FontAwesome5.getIconData(
                    'clipboard-check',
                    weight: IconWeight.Solid,
                  ),
                  size: 48,
                  color: theme.accentColor,
                ),
                text: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    'Chamadas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                width: 140,
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                backgroundColor: Colors.white,
                borderWidth: 1,
                withShadow: true,
                onTap: () async {
                  if (_classBloc.pickedClass.classStatus ==
                      ClassStatus.created) {
                    GGDialog.show(
                      context,
                      GGBasicYNDialog(
                        title: 'Atenção',
                        text: 'Se continuar, serão definidos os números de chamadas de todos os alunos da turma em ordem alfabética. Novos alunos adicionados a turma posteriormente a esse ação irão para o fim da lista de chamadas. Deseja prosseguir?',
                        onClickYes: () async {
                          await _classBloc.initializeClass(classe.id);
                          Navigator.of(context).pop();
                          gotoCallScreen(context);
                        },
                      ),
                    );
                  } else {
                    gotoCallScreen(context);
                  }
                },
              ),
              ALIconTextVerticalButton(
                icon: FontAwesome5.getIconData(
                  'clipboard-list',
                  weight: IconWeight.Solid,
                ),
                text: 'Quadro de Notas',
                route: GradeBoardScreen(),
              ),
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

  void gotoCallScreen(BuildContext context) {
    ALRouter.pushWithResolver(
      context,
      CallScreen(),
      () => BlocProvider.getBloc<CallBloc>().initializeClassStudentsFromDate(
        _classBloc.pickedClass.id,
        DateTime.now(),
      ),
    );
  }
}
