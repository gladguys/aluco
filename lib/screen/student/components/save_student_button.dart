import 'package:aluco/model/student.dart';
import 'package:aluco/routing/al_router.dart';
import 'package:aluco/theme/main_theme.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';

import '../save_student_screen.dart';
import '../student_bloc.dart';

class SaveStudentButton extends StatelessWidget {
  const SaveStudentButton({this.isFloating = true});

  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return isFloating ? _buildFab(context) : _buildOutlineButton(context);
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton.extended(
      icon: Icon(Icons.add),
      label: const Text(
        'Adicionar',
        style: TextStyle(
          fontSize: 16,
          letterSpacing: 0,
        ),
      ),
      backgroundColor: theme.primaryColor,
      foregroundColor: theme.accentColor,
      onPressed: _onPressed(context),
    );
  }

  Widget _buildOutlineButton(BuildContext context) {
    return OutlineButton.icon(
      icon: Icon(Icons.add, size: 26),
      label: const Text(
        'Adicionar',
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
    final _bloc = BlocProvider.getBloc<StudentBloc>();
    return () async {
      final Student studentToSave =
          await ALRouter.push(context, const SaveStudentScreen());
      if (studentToSave != null) {
        await _bloc.save(studentToSave);
      }
    };
  }
}
