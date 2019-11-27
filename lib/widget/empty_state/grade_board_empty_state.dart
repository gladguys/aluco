import 'package:aluco/core/routing/al_router.dart';
import 'package:aluco/screen/classes/class_home/class_home_bloc.dart';
import 'package:aluco/screen/exam/exam_bloc.dart';
import 'package:aluco/screen/exam/exams_screen.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GradeBoardEmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Não há registro de notas nessa turma.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _ExamsButton(),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExamsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(
        FontAwesome5.getIconData(
          'file-alt',
          weight: IconWeight.Solid,
        ),
        size: 20,
      ),
      label: const Text(
        'Ver Provas',
        style: TextStyle(
          fontSize: 18,
          letterSpacing: 0,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      color: theme.primaryColor,
      textColor: theme.primaryColorDark,
      highlightedBorderColor: theme.primaryColor,
      borderSide: BorderSide(color: theme.primaryColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onPressed: _onPressed(context),
    );
  }

  Function _onPressed(BuildContext context) {
    final _classBloc = BlocProvider.getBloc<ClassHomeBloc>();

    return () async {
      ALRouter.pushWithResolver(
          context,
          ExamsScreen(),
          () => BlocProvider.getBloc<ExamBloc>()
              .getExamsByClass(_classBloc.pickedClass.id));
    };
  }
}
